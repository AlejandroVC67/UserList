//
//  ServiceError.swift
//  UserList
//
//  Created by Diego Alejandro Villa Cardenas on 9/01/21.
//

import Foundation

enum ServiceError: Error, LocalizedError {
    case badUrl
    case unableToParse
    case dataError
    
    var errorDescription: String? {
        switch self {
        case .badUrl: return "Failed creating url path"
        case .unableToParse: return "Unable to parse response"
        case .dataError: return "There is an unexpected problem with the data"
        }
    }
}

