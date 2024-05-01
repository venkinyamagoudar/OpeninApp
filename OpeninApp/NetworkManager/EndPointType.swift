//
//  EndPointType.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 5/1/24.
//

import Foundation

/// Base URL for the server.
let SERVER_BASE_URL = "https://api.inopenapp.com"

/// Protocol defining the structure for an API endpoint.
protocol EndPointType {
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    var method: HTTPMethods { get }
    var body: Encodable? { get }
    var headers: [String: String]? { get }
}

extension EndPointType {
    /// Default implementation of the base URL.
    var baseURL: String {
        return SERVER_BASE_URL
    }
    
    /// Default implementation of the complete URL.
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    /// Default implementation of the body parameters.
    var body: Encodable? {
        return nil
    }
    
    /// Default implementation of the headers.
    var headers: [String: String]? {
        return nil
    }
}

/// Enumeration defining HTTP methods for requests.
enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
