//
//  MatchesResponse.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 2/10/26.
//
import Foundation

struct MatchesResponse: Decodable {
    let id: String
    let dateOfBirth: Date
    let imageUrl: String
    let displayName: String
    let gender: String
    let city: String
    let country: String
}
