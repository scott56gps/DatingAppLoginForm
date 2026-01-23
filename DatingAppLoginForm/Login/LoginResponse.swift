//
//  LoginResponse.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 1/9/26.
//

struct LoginResponse: Decodable {
    let id: String
    let email: String
    let displayName: String
    let token: String
    let imageUrl: String?
}