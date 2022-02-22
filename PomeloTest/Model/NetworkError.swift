//
//  NetworkError.swift
//  PomeloTest
//
//  Created by ERX-C02G47CEQ05N on 22/2/2565 BE.
//

import Foundation

enum NetworkError: LocalizedError {
    case unauthorized
    case tooManyRequests
    case missingURLResponse
    case serverError
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Unauthorized, please check you api key"
        case .tooManyRequests:
            return "You have attempted maximum number of calling api, please try again later"
        case .missingURLResponse:
            return "Missing url response"
        case .serverError:
            return "Internal server error"
        case .unknown:
            return "An unknown error has occurred"
        }
    }
}
