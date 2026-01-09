//
//  LoginClient.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 1/9/26.
//
import Combine
import Foundation

final class LoginClient {
    var client: NetworkClient
    let tokenProvider: JWTTokenProvider = JWTTokenProvider()
    
    init(client: NetworkClient) {
        self.client = client
    }
    
    func login(email: String, password: String) -> AnyPublisher<Void, LoginError> {
        let loginRequest = LoginRequest(email: email, password: password)
        return client.request(request: loginRequest)
            .mapError { LoginError.networkError($0.localizedDescription) }
            .tryMap { response in
                try self.tokenProvider.setToken(token: response.token.data(using: .utf8)!)
            }
            .mapError { $0 as? LoginError ?? .unknownError($0.localizedDescription) }
            .eraseToAnyPublisher()
    }
}
