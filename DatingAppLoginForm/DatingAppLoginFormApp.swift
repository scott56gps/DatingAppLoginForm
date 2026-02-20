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
    
    var body: some Scene {
        WindowGroup {
            RoutingView()
                .environmentObject(viewState)
        }
    }
}
