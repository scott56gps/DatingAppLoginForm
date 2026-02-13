//
//  MatchesRequest.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 2/10/26.
//
import Networker

struct MatchesRequest: RequestConvertible, PaginatedRequest {
    var pageNumber: Int = 1
    var pageSize: Int
    
    typealias Response = MatchesResponse
    let path: String = "/api/members"
}
