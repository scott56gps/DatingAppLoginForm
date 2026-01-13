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

    @Validated([.required, .custom(message: "Not a valid email") { $0.contains("@") }])
    var email: String = ""
    @Published var emailIsTouched = false

    @Published var isFormValid: Bool = false
    @Published var passwordsMatchError: ValidationError?
    @Published var loginState: LoginState = .loggedOut
    private let loginClient: LoginClient
    private var cancellables = Set<AnyCancellable>()

    init(loginClient: LoginClient) {
        self.loginClient = loginClient
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
        loginState = .loading
        loginClient.login(email: email, password: password)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                    case .finished: break
                    case .failure(let error):
                    let errorDescription = mapLoginErrorToDescription(error)
                    loginState = .error((error, errorDescription))
                    print(error)
                }
            }, receiveValue: { [weak self] _ in
                guard let self else { return }
                self.loginState = .loggedIn
            })
            .store(in: &cancellables)
    }
    
    private func mapLoginErrorToDescription(_ error: LoginError) -> String {
        return switch error {
        case .invalidCredentials: "Invalid Credentials"
        default: error.localizedDescription
        }
    }
}
