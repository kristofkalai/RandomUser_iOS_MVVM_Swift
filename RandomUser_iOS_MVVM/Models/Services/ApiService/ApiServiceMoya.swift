//
//  UserServiceMoya.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 15..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import Moya
import Foundation

/// Moya endpoints' definition.
enum MoyaEnums {
    case randomUsers(page: Int, results: Int, seed: String)
}

// MARK: - TargetType implementation.
extension MoyaEnums: TargetType {
    var path: String {
        switch self {
        case .randomUsers: return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .randomUsers: return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .randomUsers:
            guard let url = Bundle.main.url(forResource: "sample", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        }
    }
    
    var task: Task {
        switch self {
        case .randomUsers(let page, let results, let seed):
            return .requestParameters(parameters: [
                "inc" : "name,picture,gender,location,email,phone,cell",
                "page" : String(page),
                "results" : String(results),
                "seed" : seed
            ], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var baseURL: URL {
        return URL(string: ApiServiceContainer.getBaseApiUrl())!
    }
}

/// The `ApiServiceProtocol` implemented by Moya.
class ApiServiceMoya: ApiServiceProtocol {
    
    /// Download random users with the given parameters.
    /// - Parameters:
    ///   - page: the page that wanted to be downloaded.
    ///   - results: the number of results in a page.
    ///   - seed: the API use this to give back some data. For the same seed it gives back the same results.
    ///   - completion: will be called after the data is ready in an array, or an error occured. Both parameters in the same time couldn't be `nil`.
    func getUsers(page: Int, results: Int, seed: String, completion: @escaping (Result<[User], ErrorTypes>) -> ()) {
        // If you want to debug, use this:
        // let provider = MoyaProvider<MoyaEnums>(plugins: [NetworkLoggerPlugin()])
        let provider = MoyaProvider<MoyaEnums>()
        provider.request(.randomUsers(page: page, results: results, seed: seed)) { result in
            switch result {
            case let .success(moyaResponse):
                guard let userResult = UserResult(data: moyaResponse.data) else {
                    completion(.failure(.unexpectedError))
                    return
                }
                completion(.success(userResult.results))
            case .failure(_):
                completion(.failure(.unexpectedError))
            }
        }
    }
}
