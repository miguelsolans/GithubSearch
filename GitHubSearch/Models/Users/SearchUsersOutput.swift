//
//  SearchUsersOutput.swift
//  GitHubSearch
//
//  Created by Miguel Solans on 25/01/2022.
//

import Foundation

struct SearchUsersOutput: Decodable {
    let totalCount: Int
    let items: [UserInfoOutput]
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items = "items"
    }
}
