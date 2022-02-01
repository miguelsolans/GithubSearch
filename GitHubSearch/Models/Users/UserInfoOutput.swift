//
//  UserInfoOutput.swift
//  GitHubSearch
//
//  Created by Miguel Solans on 29/01/2022.
//

import Foundation

struct UserInfoOutput: Decodable {
    
    let username: String
    let id: Int
    let avatarUrl: String
    let type: String
    let name: String?
    let webpage: String?
    let bio: String?
    let numberOfRepos: Int?
    let company: String?
    
    private enum CodingKeys: String, CodingKey {
        case username = "login"
        case id = "id"
        case avatarUrl = "avatar_url"
        case type = "type"
        case name = "name"
        case webpage = "blog"
        case bio = "bio"
        case numberOfRepos = "public_repos"
        case company = "company"
    }
    
}
