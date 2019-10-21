//
//  NetworkManager.swift
//  Nike-Coding-Challenge
//
//  Created by Ritu Patel on 10/20/19.
//  Copyright © 2019 Ritu Patel. All rights reserved.
//

import Foundation

// This protocol is for network call

protocol NetworkProtocol {
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    func performRequest(for url: URL, completionHandler: @escaping Handler)
}

/// This class handles netwrok calls

class NetworkManager {
    
    private let manager: NetworkProtocol
    
    /**
     This initialize manager. But for testing purpose it is injected with protocol in order to doesn't affect shared instance of app
     
     - Parameter 1: manager -> This will be type of NetworkProtocol and inject mock class which conforms to NetworkProtocol
     */
    
    init(manager: NetworkProtocol = URLSession.shared) {
        self.manager = manager
    }
    
    
    //MARK:- Netwrok call helpers
    
    /// Invoke the url, and using completionHandler pass success or failure along with data or error to the viewModel
    
    private func invoke(WithUrl url: URL, completionHandler: @escaping (Result) -> ()) {
        
        manager.performRequest(for: url) { (data, response, error) in
            if let error = error {
                completionHandler(.error(error))
            }else if let data = data {
                completionHandler(.data(data))
            }
        }
    }
    
    /// Generic method for making service call of response model [T?], once it receives response, serialize the json and pass it using completionHandler
    
    func fetchData<T:Codable>(WithUrl url: URL, objectType: T.Type, completionHandler: @escaping (T?, Error?) -> ()) {
        
        DispatchQueue.global().async {
            
            self.invoke(WithUrl: url) { (result) in
                
                switch result {
                    
                case .data(let data):
                    do{
                        let jsonData = try JSONDecoder().decode(T.self, from: data)
                        
                        DispatchQueue.main.async {
                           completionHandler(jsonData, nil)
                        }
                    } catch{
                        print("Caught JSONSerialization error")
                    }
                    
                case .error(let error):
                    DispatchQueue.main.async {
                        completionHandler(nil, error)
                    }
                }
            }
        }
    }
}

//MARK:- interface URLSession

extension URLSession: NetworkProtocol {
    
    typealias Handler = NetworkProtocol.Handler
    
    /// Perform request with url
    func performRequest(for url: URL, completionHandler: @escaping Handler) {
        let task = dataTask(with: url, completionHandler: completionHandler)
        task.resume()
    }
}


//MARK:- Enums

/**
Result enum is with two cases
 
 - Case 1: data -> It will be associated with data
 - Case 2: error -> It will be associated with error
 */
enum Result {
    case data(Data)
    case error(Error)
}

/// Endpoints enum

enum Endpoints: String{
    case url = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"
}
