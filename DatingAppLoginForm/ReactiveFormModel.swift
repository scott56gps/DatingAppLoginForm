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
    private let client: AuthenticatedNetworkClient
    
    init(client: AuthenticatedNetworkClient) {
        self.client = client
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
        let loginRequest = LoginRequest(email: email, password: password)
        client.request(request: loginRequest)
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

struct LoginRequest: JSONBodyRequest {
    typealias Response = LoginResponse
    var method: HTTPMethod { .post }
    var path: String {
        "/api/account/login"
    }
    
    let email: String
    let password: String
    var body: [String: String] {
        ["Email": email, "Password": password]
    }
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
