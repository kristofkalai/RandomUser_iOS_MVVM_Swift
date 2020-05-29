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
    
    func getUsers(page: Int, results: Int, seed: String, completion: @escaping (Result<[User], ErrorTypes>) -> ()) {
        guard let url = createUrl(page, results, seed) else {
            completion(.failure(.cannotBeReached))
            return
        }
        AF.request(url).responseJSON { response in
            do {
                if response.error != nil || response.response?.statusCode == nil {
                    completion(.failure(.wrongRequest))
                } else if response.response!.statusCode < 400 {
                    let userResult = try JSONDecoder().decode(UserResult.self, from: response.data!)
                    completion(.success(userResult.results))
                } else {
                    completion(.failure(.unexpectedError))
                }
            } catch {
                completion(.failure(.unexpectedError))
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
