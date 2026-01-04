//
//  Validator.swift
//  FormValidation
//
//  Created by Scott Nicholes on 12/11/25.
//
import Foundation
import Combine

@propertyWrapper
final class Validated<Value: Equatable>: ObservableObject {
    @Published var value: Value
    @Published private(set) var errors: [ValidationError] = []
    
    private let validationRules: [ValidationRule<Value>]
    private var cancellables: Set<AnyCancellable> = []
    
    // Expose a publisher for the field's validation state
    var validationPublisher: AnyPublisher<[ValidationError], Never> {
        $errors.eraseToAnyPublisher()
    }
    
    var wrappedValue: Value {
        get { value }
        set { value = newValue }
    }
    
    var projectedValue: Validated<Value> { self } // MARK: Why do we do this?
    
    init(wrappedValue initialValue: Value, _ rules: [ValidationRule<Value>]) {
        self.value = initialValue
        self.validationRules = rules
        
        setupValidationPipeline()
    }
    
    private func setupValidationPipeline() {
        // Observe changes to the value and validate automatically
        $value
            .debounce(
                for: .milliseconds(250),
                scheduler: RunLoop.main
            ) // Needed so we don't re-run validation if a user deletes a char and then retypes it
            .removeDuplicates { lhs, rhs in
                return lhs == rhs
            }
            .sink { [weak self] newValue in
                guard let self else { return }
                self.errors = self.runValidationRules(on: newValue)
            }
            .store(in: &cancellables)
    }
    
    private func runValidationRules(on value: Value) -> [ValidationError] { // MARK: What is 'on'?
        return validationRules
            .map( { $0.validate(value) } )
            .compactMap( \.self )
    }
}
