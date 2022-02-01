//
//  RepositoriesModel.swift
//  GitHubSearch
//
//  Created by Miguel Solans on 29/01/2022.
//

import Foundation

protocol RepositoriesModelDelegate {
    func didFailWithError(_ error: Error, endpoint: String);
    func didReceiveRepositoryInfo(output: [RepositoryInfoOutput]);
}

struct RepositoriesModel {
    let baseUrl = "https://api.github.com/"
    var delegate: RepositoriesModelDelegate?
    var request = Request();
    
    func fetchUserRepositories(username: String) {
        // let urlStr = "\(self.baseUrl)search/users?q=\(keyword)";
        let urlStr = "\(self.baseUrl)users/\(username)/repos";
        self.request.performGetArray(urlString: urlStr) { (output: [RepositoryInfoOutput]) in
            self.delegate?.didReceiveRepositoryInfo(output: output);
        } failure: { error in
            self.delegate?.didFailWithError(error, endpoint: urlStr)
        }
        
    }
}
