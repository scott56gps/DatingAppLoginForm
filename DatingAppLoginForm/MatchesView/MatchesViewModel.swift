//
//  MatchesViewModel.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 1/23/26.
//
import Foundation
import Combine

class MatchesViewModel: ObservableObject {
    private let client: MatchesClient
    @Published var matches: [Match] = []
    private var cancellables = Set<AnyCancellable>()

    //    @Published var matchItems: [Match] = [
    //        Match(
    //            name: "Scott Nicholes",
    //            location: "Claremont, CA",
    //            imageUrl: "sample_profile_picture"
    //        ),
    //        Match(
    //            name: "Echo Nicholes",
    //            location: "Hermiston, OR",
    //            imageUrl: "sample_profile_picture"
    //        )
    //    ]
    
    init(client: MatchesClient) {
        self.client = client
        
        // MARK: Just for testing
        getMatches()
    }
    
    func getMatches() {
        client.getMatches(pageNumber: 1, pageSize: 5)
            .sink(receiveValue: { [weak self] matches in
                self?.matches = matches
            })
            .store(in: &cancellables)
    }
}

