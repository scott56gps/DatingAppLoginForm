//
//  NetworkClient.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 1/5/26.
//
import Networker
import Combine

protocol NetworkClient {
    // MARK: Replace Networker Error with Domain Error
    func request<T: RequestConvertible>(request: T) -> AnyPublisher<T.Response, NetworkRequestError>
}
