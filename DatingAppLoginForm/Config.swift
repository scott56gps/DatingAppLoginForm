//
//  Config.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 2/25/26.
//

import Foundation

enum Config {
    static var apiBaseURL: String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String else {
            fatalError("API_BASE_URL is not set in Info.plist")
        }
        return value
    }
}
