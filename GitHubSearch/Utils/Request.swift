//
//  Request.swift
//  GitHubSearch
//
//  Created by Miguel Solans on 29/01/2022.
//

import Foundation

class Request {
    
    func performGetDictionary<T: Decodable>(urlString: String, completion: @escaping ((T) ->Void), failure: @escaping ((Error) -> Void)) {
        if let safeUrl = URL(string: urlString) {
            
            var request = URLRequest(url: safeUrl);
            
            request.httpMethod = "GET";
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                
                if(error != nil) { }
                
                if let safeData = data {
                    
                    do {
                        let output = try JSONDecoder().decode(T.self, from: safeData)
                        completion(output)
                    } catch {
                        
                        failure(error)
        
                    }
                }
            })
            
            task.resume()
        }
    }
    
    func performGetArray<T: Decodable>(urlString: String, completion: @escaping (([T]) ->Void), failure: @escaping ((Error) -> Void)) {
        if let safeUrl = URL(string: urlString) {
            
            var request = URLRequest(url: safeUrl);
            
            request.httpMethod = "GET";
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                
                if(error != nil) { }
                
                if let safeData = data {
                    
                    do {
                        let output = try JSONDecoder().decode([T].self, from: safeData)
                        completion(output)
                    } catch {
                        
                        failure(error)
        
                    }
                }
            })
            
            task.resume()
        }
    }
}
