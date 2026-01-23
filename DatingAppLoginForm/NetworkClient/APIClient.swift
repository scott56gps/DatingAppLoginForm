//
//  APIClient.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 1/9/26.
//
import Networker
import Combine

final class APIClient: NetworkClient {
    private let networker: Networker
    
    init(networker: Networker) {
        self.networker = networker
    }
    
    func request<T>(request: T) -> AnyPublisher<T.Response, NetworkRequestError> where T : RequestConvertible {
        networker.request(request)
            .eraseToAnyPublisher()
    }
}
