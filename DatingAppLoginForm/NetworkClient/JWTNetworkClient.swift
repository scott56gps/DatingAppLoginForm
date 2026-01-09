//
//  JWTNetworkClient.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 1/5/26.
//
import Networker
import Combine

final class JWTNetworkClient: AuthenticatedNetworkClient {
    private let networker: Networker
    private let tokenProvider = JWTTokenProvider()
    
    init(networker: Networker) {
        self.networker = networker
    }
    
    func request<T>(request: T) -> AnyPublisher<T.Response, NetworkRequestError> where T : RequestConvertible {
        networker.request(request)
            .eraseToAnyPublisher()
    }
}

