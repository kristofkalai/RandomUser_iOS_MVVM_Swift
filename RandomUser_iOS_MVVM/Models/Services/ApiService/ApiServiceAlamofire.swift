//
//  UserService.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 12..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import Alamofire
import Foundation

/// The `ApiServiceProtocol` implemented by Alamofire.
final class ApiServiceAlamofire: ApiServiceProtocol {
    /// Download random users with the given parameters.
    /// - Parameters:
    ///   - page: the page that wanted to be downloaded.
    ///   - results: the number of results in a page.
    ///   - seed: the API use this to give back some data. For the same seed it gives back the same results.
    ///   - completion: will be called after the data is ready in an array, or an error occured. Both parameters in the same time couldn't be `nil`.
    func getUsers(page: Int, results: Int, seed: String, completion: @escaping (Result<[User], ErrorTypes>) -> ()) {
        guard let url = ApiServiceContainer.createUrl(page, results, seed) else {
            return completion(.failure(.cannotBeReached))
        }
        AF.request(url).responseDecodable(of: UserResult.self) { response in
            if let result = response.response, result.statusCode < 400 {
                guard let userResult = UserResult(data: response.data) else {
                    return completion(.failure(.unexpectedError))
                }
                return completion(.success(userResult.results))
            } else if response.error != nil {
                return completion(.failure(.wrongRequest))
            }
            return completion(.failure(.unexpectedError))
        }
    }
}
