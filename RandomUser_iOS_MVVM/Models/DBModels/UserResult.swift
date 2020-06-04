//
//  UserResult.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 12..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import Foundation

struct UserResult: Codable {
    let results: [User]
    
    init?(data: Data?) {
        guard let data = data else { return nil }
        do {
            self = try JSONDecoder().decode(UserResult.self, from: data)
        } catch {
            return nil
        }
    }
}
