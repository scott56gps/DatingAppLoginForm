//
//  TokenProvider.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 1/5/26.
//
import Foundation
import Combine

protocol TokenProvider {
    func getToken() throws -> Data?
    func setToken(token: Data) throws
}
