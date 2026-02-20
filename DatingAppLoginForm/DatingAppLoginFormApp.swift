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
    @StateObject private var viewState: Router = Router()

    private let configBuilder = DatingAppLoginFormConfigBuilder(
        apiClient: APIClient(networker: Networker(baseURL: "http://10.4.255.153:8080"))
    )
    
    var body: some Scene {
        WindowGroup {
            RoutingView(dependencyBuilder: configBuilder)
                .environmentObject(viewState)
        }
    }
}
