//
//  File.swift
//  
//
//  Created by Igor Chernobai on 9/23/24.
//

import Foundation

public enum NetworkingError: Error {
    case badURL
    case badResponse
    case badRequest(String)
    case decodingError(String)
    case networkError(Error)
    case unknownError(UnknownError)
    case canceled(String)
    
    public var descriptionText: String {
        switch self {
        case .badURL:
            return "Bad URL"
        case .badResponse:
            return "Bad Response"
        case let .badRequest(message):
            return message
        case let .decodingError(message):
            return message
        case let .networkError(error):
            return error.localizedDescription
        case let .unknownError(error):
            return error.localizedDescription
        case let .canceled(message):
            return message
        }
    }
}

public enum UnknownError: Error {
    case errorData(Data)
    case error(Error)
}
