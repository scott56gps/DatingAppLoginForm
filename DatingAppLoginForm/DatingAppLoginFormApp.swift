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
    var body: some Scene {
        WindowGroup {
            ReactiveForm(
                model: ReactiveFormModel(
                    loginClient: LoginClient(
                        client: APIClient(networker: Networker(baseURL: "http://10.4.255.153:8080")))))
        }
    }
}
