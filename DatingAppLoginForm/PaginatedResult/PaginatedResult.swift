//
//  PaginatedResult.swift
//  DatingAppLoginForm
//
//  Created by Scott Nicholes on 2/9/26.
//

struct PaginatedResult<T> {
    let metadata: PaginatedMetadata
    let items: [T]
}
