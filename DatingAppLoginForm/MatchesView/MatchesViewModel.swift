//
//  MatchesViewModel.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 1/23/26.
//
import Foundation
import Combine

class MatchesViewModel: ObservableObject {
    @Published var matchItems: [MatchItem] = [
        MatchItem(
            name: "Scott Nicholes",
            location: "Claremont, CA",
            imageUrl: "sample_profile_picture"
        ),
        MatchItem(
            name: "Echo Nicholes",
            location: "Hermiston, OR",
            imageUrl: "sample_profile_picture"
        )
    ]
    var customMatchName: String = ""
    
    func addMatch() {
        matchItems.append(MatchItem(name: customMatchName, location: "Umatilla, OR", imageUrl: "sample_profile_picture"))
    }
}

