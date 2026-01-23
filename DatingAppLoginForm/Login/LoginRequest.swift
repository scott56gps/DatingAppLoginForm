//
//  LoginRequest.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 1/9/26.
//
import Networker

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
