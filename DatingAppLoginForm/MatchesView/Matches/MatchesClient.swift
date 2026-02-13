//
//  MatchesClient.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 2/12/26.
//
import Combine

final class MatchesClient {
    func getMatches(pageNumber: Int, pageSize: Int) -> AnyPublisher<[Match], Never> {
        Just([
        Match(
            name: "Scott Nicholes",
            location: "Claremont, CA",
            imageUrl: "sample_profile_picture"
        ),
        Match(
            name: "Echo Nicholes",
            location: "Hermiston, OR",
            imageUrl: "sample_profile_picture"
        )
        ]).eraseToAnyPublisher()
    }
}
