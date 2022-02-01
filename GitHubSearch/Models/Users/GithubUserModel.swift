//
//  GithubUserModel.swift
//  GitHubSearch
//
//  Created by Miguel Solans on 25/01/2022.
//

import Foundation

protocol GithubUserModelDelegate {
    
    func didFailWithError(_ error: Error, endpoint: String);
    func searchOutputDidChange(output: SearchUsersOutput);
    func userInfoOutputDidChange(output: UserInfoOutput);
}

struct GithubUserModel {
    
    let baseUrl = "https://api.github.com/"
    var delegate: GithubUserModelDelegate?
    var request = Request();
    
    func fetchAccountsWith(keyword: String) {
        let urlStr = "\(self.baseUrl)search/users?q=\(keyword)"
        
        self.request.performGetDictionary(urlString: urlStr) { (output: SearchUsersOutput) in
            self.delegate?.searchOutputDidChange(output: output)
        } failure: { error in
            self.delegate?.didFailWithError(error, endpoint: urlStr)
        }
    }
    
    func fetchAccountInformation(username: String) {
        let urlStr = "\(self.baseUrl)users/\(username)";
        
        self.request.performGetDictionary(urlString: urlStr) { (output: UserInfoOutput) in
            self.delegate?.userInfoOutputDidChange(output: output);
        } failure: { error in
            self.delegate?.didFailWithError(error, endpoint: urlStr)
        }

    }
    
}
