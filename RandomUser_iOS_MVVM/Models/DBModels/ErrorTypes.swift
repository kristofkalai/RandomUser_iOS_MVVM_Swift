//
//  ErrorTypes.swift
//  RandomUser
//
//  Created by Kálai Kristóf on 2020. 05. 19..
//  Copyright © 2020. Kálai Kristóf. All rights reserved.
//

import Foundation

enum ErrorTypes: String, Error {
    
    case wrongRequest = "Wrong request. Please try again later."
    case cannotBeReached = "API cannot be reached. Please try again later."
    case unexpectedError = "Something unexpectedly went wrong. Please inform us via email."
}
