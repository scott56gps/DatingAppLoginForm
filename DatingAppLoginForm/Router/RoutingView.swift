//
//  RoutingView.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 2/20/26.
//
import SwiftUI
import Networker

struct RoutingView: View {
    @EnvironmentObject var router: Router
    let dependencyBuilder: DatingAppLoginFormConfigBuilder
        
    var body: some View {
        switch router.currentView {
        case .login:
            dependencyBuilder.makeLoginView(router: router)
        case .matches:
            dependencyBuilder.makeMatchesView(router: router)
        }
    }
}

//#Preview {
//    RoutingView()
//}
