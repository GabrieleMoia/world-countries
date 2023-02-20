//
//  NetworkManager.swift
//  CountryWorld
//
//  Created by Gabriele Moia on 18/02/23.
//

import Foundation

class NetworkManager: NSObject {
    
    static func apiRequest<T: Decodable>(request: URLRequest,
                                         _ success: @escaping (_ response: T) -> Void,
                                         _ failure: @escaping (_ error: Error) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let response = try? JSONDecoder().decode(T.self, from: data) {
                success(response)
            } else if let error = error {
                failure(error)
                print("HTTP Request Failed \(error)")
            }
        }
        
        task.resume()
    }
}
