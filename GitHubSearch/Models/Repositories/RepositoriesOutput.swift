//
//  RepositoriesOutput.swift
//  GitHubSearch
//
//  Created by Miguel Solans on 29/01/2022.
//

import Foundation

struct RepositoryInfoOutput: Codable {
    let name: String
    let fork: Bool
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case fork = "fork"
        case url = "html_url"
    }
}
