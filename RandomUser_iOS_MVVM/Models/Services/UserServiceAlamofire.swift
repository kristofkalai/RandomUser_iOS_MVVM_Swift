//
//  UserService.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 12..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import Foundation
import Alamofire

/// The service, which used to download user-related data.
class UserServiceAlamofire: RandomUserServiceProtocol {
    
    private var isFetching = false
    
    func getUsers(page: Int, results: Int, seed: String, completion: @escaping ([User]?, String?) -> ()) {
        guard let url = createUrl(page, results, seed) else {
            completion(nil, errorTypes.cannotBeReached.rawValue)
            return
        }
        if isFetching {
            return
        }
        
        isFetching = true
        AF.request(url).responseJSON { response in
            self.isFetching = false
            
            do {
                if response.error != nil || response.response?.statusCode == nil {
                    throw RuntimeError(response.error?.localizedDescription ?? errorTypes.wrongRequest.rawValue)
                } else if response.response!.statusCode < 400 {
                    let userResult = try JSONDecoder().decode(UserResult.self, from: response.data!)
                    completion(userResult.results, nil)
                } else {
                    throw RuntimeError(errorTypes.unexpectedError.rawValue)
                }
            } catch let error {
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    /// Creates an `URL` with the given query parameters.
    /// - Note:
    /// The `URL` stores that too, that which data will be requested.
    /// The result of this method request from the API the `name`, `picture`, `gender`, `location`, `email`, `phone` and `cell`.
    private func createUrl(_ page: Int, _ results: Int, _ seed: String) -> URL? {
        let queryItems = [URLQueryItem(name: "inc", value: "name,picture,gender,location,email,phone,cell"),
                          URLQueryItem(name: "page", value: String(page)),
                          URLQueryItem(name: "results", value: String(results)),
                          URLQueryItem(name: "seed", value: String(seed))]
        guard var urlComps = URLComponents(string: getBaseApiUrl()) else { return nil }
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else { return nil }
        return url
    }
}
