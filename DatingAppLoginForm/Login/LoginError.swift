//
//  LoginError.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 1/9/26.
//
import Networker

enum LoginError: Error {
    case networkError(NetworkRequestError)
    case invalidCredentials
    case tokenError(TokenError)
    case unknownError(String)
}
