//
//  ResponseHandler.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 5/1/24.
//

import Foundation

/// Protocol defining the interface for a response handler.
protocol ResponseHandler {
    
    /// Parses and decodes the response data into the specified model type.
    /// - Parameters:
    ///   - data: The data received in the response.
    ///   - modelType: The type of the model to decode the data into.
    /// - Returns: A tuple containing the decoded model and an optional error.
    func parseResponseDecode<T: Decodable>(
        data: Data,
        modelType: T.Type
    ) -> (model: T?, error: Error?)
}

extension ResponseHandler {
    /// Default implementation of parsing and decoding response data.
    /// - Parameters:
    ///   - data: The data received in the response.
    ///   - modelType: The type of the model to decode the data into.
    /// - Returns: A tuple containing the decoded model and an optional error.
    func parseResponseDecode<T: Decodable>(
        data: Data,
        modelType: T.Type
    ) -> (model: T?, error: Error?) {
        do {
            let userResponse = try JSONDecoder().decode(modelType, from: data)
            return (userResponse, nil)
        } catch {
            return (nil, DataError.decoding(error))
        }
    }
}

/// Implementation of the `ResponseHandler` protocol using URLSession.
class ResponseHandlerURLSession : ResponseHandler { }
