//
//  NetworkErrors.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 5/1/24.
//

import SwiftUI

/// Type alias representing HTTP status code.
typealias HttpStatusCode = Int

/// Type alias for a closure used as a completion handler for API requests.
typealias NewResultHandler<T> = (_ result: T?, _ statusCode: HttpStatusCode?, _ error: DataError?) -> Void

/// Enum representing success cases for data responses.
enum DataSuccess {
    case success(Data?, HttpStatusCode)
}

/// Enum representing various error cases for data responses.
enum DataError: Error {
    case invalidResponse(Data?, HttpStatusCode)
    
    case invalidURL
    case internet
    case invalidData(HttpStatusCode, Error?)
    case network(Error?)
    case decoding(Error?)
    case unknown(Error?)
    case error(String?)
    case noDataAvailable
    
    var errorMessage: String? {
        switch self {
        case .invalidResponse:
            return "invalid Response"
        case .invalidURL:
            return "invalid URL"
        case .internet:
            return "No Internet"
        case .invalidData(_, let error):
            return error?.localizedDescription ?? "Invalid Data Error"
        case .network(let error):
            return error?.localizedDescription ?? "Network Error"
        case .decoding(let error):
            return error?.localizedDescription ?? "Decoding Data Error"
        case .unknown(let error):
            return error?.localizedDescription ?? "Unknown Error"
        case .noDataAvailable:
            return "No Data Available"
        case .error(let message):
            return message ?? "Unknown Error"
        }
    }
}
