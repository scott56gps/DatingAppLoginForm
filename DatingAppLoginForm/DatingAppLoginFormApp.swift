//
//  DatingAppLoginFormApp.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 1/1/26.
//

import SwiftUI

@main
struct DatingAppLoginFormApp: App {
    var body: some Scene {
        WindowGroup {
            ReactiveForm(model: ReactiveFormModel())
        }
    }
}
