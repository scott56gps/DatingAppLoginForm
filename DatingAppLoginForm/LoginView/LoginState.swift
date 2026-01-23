//
//  LoginState.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 1/9/26.
//

enum LoginState {
    case loggedIn
    case loggedOut
    case error((LoginError, String))
    case loading
}
