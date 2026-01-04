//
//  ReactiveFormModel.swift
//  FormValidation
//
//  Created by Scott Nicholes on 12/11/25.
//

import Combine
import SwiftUI
import Networker

class ReactiveFormModel: ObservableObject {
    @Validated([.required, .minLength(4)])
    var password: String = ""
    @Published var passwordIsTouched = false

    @Validated([.required, .minLength(4)])
    var confirmPassword: String = ""
    @Published var confirmPasswordIsTouched = false

    @Validated(
        [.required, .custom(message: "Not a valid email") { $0.contains("@") }]
    )
    var email: String = ""
    @Published var emailIsTouched = false

    private var cancellables = Set<AnyCancellable>()
    @Published var isFormValid: Bool = false
    @Published var passwordsMatchError: ValidationError?
    
    init() {
        validateFields()
    }
    private func validateFields() {
        Publishers.CombineLatest($password.$value, $confirmPassword.$value)
            .sink {
                [weak self] password, confirmPassword in
                guard let self else { return }
                
                if password != confirmPassword {
                    self.passwordsMatchError = ValidationError(
                        message: "Passwords do not match"
                    )
                } else {
                    self.passwordsMatchError = nil
                }
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest4(
            $password.validationPublisher,
            $confirmPassword.validationPublisher,
            $email.validationPublisher,
            $passwordsMatchError)
        .map {
            [weak self] passwordErrors,
            confirmPasswordErrors,
            emailErrors,
            passwordsMatchError in
            guard let self else { return false }
            return passwordErrors.isEmpty && confirmPasswordErrors.isEmpty &&
            emailErrors.isEmpty && passwordsMatchError == nil &&
            self.passwordIsTouched && self.confirmPasswordIsTouched && self.emailIsTouched
        }
        .assign(to: &$isFormValid)
    }
    
    func makeRequest() {
        let networker = Networker(
            baseURL: "https://jsonplaceholder.typicode.com"
        )
        networker.request(UserGetRequest())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: print("Finished request")
                case .failure(let error): print("Error: \(error)")
                }
            }, receiveValue: { value in
                print("Got User: \(value.title)")
            })
            .store(in: &cancellables)
    }
}

struct User: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

struct UserGetRequest: RequestConvertible {
    typealias Response = User
    
    var path: String {
        "/todos/1"
    }
}
