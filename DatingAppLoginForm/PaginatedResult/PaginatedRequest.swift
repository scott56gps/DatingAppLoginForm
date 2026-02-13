//
//  PaginatedRequest.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 2/10/26.
//

protocol PaginatedRequest {
    var pageNumber: Int { get }
    var pageSize: Int { get }
}
