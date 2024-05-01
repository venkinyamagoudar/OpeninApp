//
//  EndPointType.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 5/1/24.
//

import Foundation

let SERVER_BASE_URL = "https://api.inopenapp.com"

protocol EndPointType {
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    var method: HTTPMethods { get }
    var body: Encodable? { get }
    var headers: [String: String]? { get }
}

extension EndPointType {
    var baseURL: String {
        return SERVER_BASE_URL
    }
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    var body: Encodable? {
        return nil
    }
    var headers: [String : String]? {
        return nil
    }
}

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
