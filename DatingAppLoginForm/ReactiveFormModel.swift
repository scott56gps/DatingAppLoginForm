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
            baseURL: "https://localhost:5001"
        )
        let loginRequest = LoginRequest(email: email, password: password)
        networker.request(loginRequest)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: print("Finished request")
                case .failure(let error): print("Error: \(error)")
                }
            }, receiveValue: { value in
                print("Got token: \(value.token)")
            })
            .store(in: &cancellables)
    }
}

struct LoginResponse: Decodable {
    let id: String
    let email: String
    let displayName: String
    let token: String
    let imageUrl: String?
}

struct LoginRequest: RequestConvertible {
    typealias Response = LoginResponse
    
    var method: HTTPMethod { .post }
    var body: Data?
    var path: String {
        "/api/account/login"
    }
    
    init(email: String, password: String) {
        body = """
        {
            "email": "\(email)",
            "password": "\(password)"
        }
    """.data(using: .utf8)
    }
}
