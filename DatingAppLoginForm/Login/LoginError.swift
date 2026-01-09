//
//  LoginError.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 1/9/26.
//

enum LoginError: Error {
    case networkError(String)
    case invalidCredentials
    case tokenError(TokenError)
    case unknownError(String)
}
