//
//  Router.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 2/20/26.
//
import SwiftUI
import Combine

class Router: ObservableObject, RouteModifiable {
    // This is the piece of state that defines what screen we are currently looking at
    @Published var currentView: Screen = .login
    
    func showMatches() {
        currentView = .matches
    }
    
    func showLogin() {
        currentView = .login
    }
}

protocol RouteModifiable {
    func showMatches()
    func showLogin()
}

enum Screen {
    case matches
    case login
}
