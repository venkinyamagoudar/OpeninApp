//
//  NetworkHandlerURLSession.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 5/1/24.
//

import Foundation
import Combine

/// Protocol defining the interface for a network handler.
protocol NetworkHandler {
    
    /// Performs a data request using the specified URLRequest.
    /// - Parameters:
    ///   - urlRequest: The URLRequest object representing the request.
    ///   - completionHandler: A closure to be called upon request completion, containing a Result enum with either success or failure.
    func requestDataAPI(
        urlRequest: URLRequest,
        completionHandler: @escaping (Result<DataSuccess, DataError>) -> Void
    )
    
    /// Validates the response received from the network.
    /// - Parameter urlResponse: The URLResponse object received from the network.
    /// - Returns: A tuple indicating whether the response is successful and the status code.
    func validateResponse(_ urlResponse: URLResponse?) -> (success: Bool, statusCode: HttpStatusCode)
}


extension NetworkHandler {
    /// Default implementation of response validation.
    /// - Parameter urlResponse: The URLResponse object received from the network.
    /// - Returns: A tuple indicating whether the response is successful and the status code.
    func validateResponse(_ urlResponse: URLResponse?) -> (success: Bool, statusCode: HttpStatusCode) {
        if let response = urlResponse as? HTTPURLResponse {
            guard APIManager.isValidHttp(code: response.statusCode) else {
                return (false, response.statusCode)
            }
            return (true, response.statusCode)
        }
        return (false, -1)
    }
}

/// Implementation of the `NetworkHandler` protocol using URLSession.
class NetworkHandlerURLSession : NetworkHandler {
    private var cancellables = Set<AnyCancellable>()
    
    /// URLSession instance used for network requests.
    let urlSession: URLSession = {
        let urlSession = URLSession.shared
        urlSession.configuration.timeoutIntervalForRequest = 15
        return urlSession
    }()
    
    init() { }
    
    /// Performs a data request using the specified URLRequest.
    /// - Parameters:
    ///   - urlRequest: The URLRequest object representing the request.
    ///   - completionHandler: A closure to be called upon request completion, containing a Result enum with either success or failure.
    func requestDataAPI(urlRequest: URLRequest,completionHandler: @escaping (Result<DataSuccess, DataError>) -> Void) {
        requestFuture(urlRequest: urlRequest).sink { completion in
            switch completion {
            case .failure(let err):
                print("Error is \(err.localizedDescription)")
                completionHandler(.failure(err))
            case .finished:
                print("Finished")
            }
        }
        receiveValue: { responseData in
            completionHandler(.success(responseData))
        }
        .store(in: &cancellables)
    }
    
    /// Performs a data request returning a Future.
    /// - Parameter urlRequest: The URLRequest object representing the request.
    /// - Returns: A Future object encapsulating the result of the request.
    func requestFuture(urlRequest: URLRequest) -> Future<DataSuccess, DataError> {
        return Future<DataSuccess, DataError>() { [weak self] promise in
            guard let self else { return }
            var statusCode: HttpStatusCode = -1
            self.urlSession.dataTaskPublisher(for: urlRequest)
                .tryMap { (data, response) -> Data in
                    let validationData = self.validateResponse(response)
                    statusCode = validationData.statusCode
                    guard validationData.success else {
                        throw DataError.invalidResponse(data, statusCode)
                    }
                    
                    return data
                }
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(DataError.decoding(decodingError)))
                        case let apiError as DataError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(DataError.unknown(error)))
                        }
                    }
                }, receiveValue: {
                    promise(.success(DataSuccess.success($0, statusCode)))
                })
                .store(in: &self.cancellables)
        }
    }
}
