//
//  DependencyBuilder.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 2/20/26.
//

import SwiftUI
import Networker

final class DatingAppLoginFormConfigBuilder {
    let apiClient: NetworkClient
    
    init(apiClient: NetworkClient) {
        self.apiClient = apiClient
    }
    
    convenience init() {
        self.init(apiClient: Self.makeDefaultNetworkClient())
    }
    
    private static func makeDefaultNetworkClient() -> NetworkClient {
        guard let baseURL = URL(string: Config.apiBaseURL) else {
            fatalError("Invalid API base url in Config")
        }
        return APIClient(networker: Networker(baseURL: baseURL))
    }
    
    // MARK: - Feature Builders
    /// This is the place where features of the app that require configuration go
    func makeLoginView(router: RouteModifiable) -> some View {
        let loginClient = LoginClient(client: apiClient)
        let loginViewModel = LoginViewModel(loginClient: loginClient, router: router)
        return LoginView(model: loginViewModel)
    }
    
    func makeMatchesView(router: RouteModifiable) -> some View {
        let matchesClient = MatchesClient()
        let viewModel = MatchesViewModel(client: matchesClient)
        return MatchesView(viewModel: viewModel)
    }
}
