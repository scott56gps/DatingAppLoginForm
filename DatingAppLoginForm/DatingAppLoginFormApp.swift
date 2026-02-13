//
//  DatingAppLoginFormApp.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 1/1/26.
//

import SwiftUI
import Networker

@main
struct DatingAppLoginFormApp: App {
    @State var appView: AppView = .login
    
    var body: some Scene {
        WindowGroup {
            switch appView {
            case .login:
                LoginView(
                    model: LoginViewModel(
                        loginClient: LoginClient(
                            client: APIClient(
                                networker: Networker(
                                    baseURL: "http://10.4.255.153:8080"
                                )
                            )
                        )
                    ), onLogin: {
                        appView = .matches
                    }
                )
            case .matches:
                MatchesView()
            }
        }
    }
}
