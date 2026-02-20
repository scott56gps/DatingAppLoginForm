//
//  RoutingView.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 2/20/26.
//
import SwiftUI
import Networker

struct RoutingView: View {
    @EnvironmentObject var viewState: Router
    
    var body: some View {
        switch viewState.currentView {
        case .login:
            LoginView(
                model: LoginViewModel(
                    loginClient: LoginClient(
                        client: APIClient(
                            networker: Networker(
                                baseURL: "http://10.4.255.153:8080"
                            )
                        )
                    ), router: viewState
                )
            )
        case .matches:
            MatchesView()
        }
    }
}

#Preview {
    RoutingView()
}
