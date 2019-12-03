//
//  Result.swift
//  BucketList
//
//  Created by Angel Vázquez on 02/12/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}
