//
//  NetworkError.swift
//  UsersList
//
//  Created by Roman Golub on 26.03.2025.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case serverError
    case invalidData
    case unkown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .serverError:
            return "There was an error with the server. Please try again later"
        case .invalidData:
            return "The data is invalid. Please try again later"
        case .unkown(let error):
            return error.localizedDescription
        }
    }
}
