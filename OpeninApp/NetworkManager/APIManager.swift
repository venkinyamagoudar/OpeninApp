//
//  APIManager.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 5/1/24.
//

import SwiftUI


final class APIManager {
    static let shared = APIManager(networkHandler: NetworkHandlerURLSession(), responseHandler: ResponseHandlerURLSession())
    private let networkHandler: NetworkHandler
    private let responseHandler: ResponseHandler
    
    private let authToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI"
    
    init(networkHandler: NetworkHandler, responseHandler: ResponseHandler) {
        self.networkHandler = networkHandler
        self.responseHandler = responseHandler
    }
}

extension APIManager {
    @discardableResult
    func request<T: Decodable>(
        modelType: T.Type,
        type: EndPointType,
        showProgressHUD: Bool = true,
        completion: @escaping NewResultHandler<T>
    ) -> URLRequest? {
        guard let url = type.url else {
            completion(nil, 404, .invalidURL)
            return nil
        }
        guard NetworkReachability.shared.isNetworkAvailable() else {
            completion(nil, 503, .internet)
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get.rawValue
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        if showProgressHUD {
            ProgressLoader.shared.startLoading()
        }
        
        func callCompletion(_ result: T?, _ statusCode: HttpStatusCode?, _ error: DataError?) {
            DispatchQueue.main.async {
                completion(result, statusCode, error)
                if showProgressHUD {
                    ProgressLoader.shared.stopLoading()
                }
            }
        }
        
        networkHandler.requestDataAPI(urlRequest: request) { result in
            switch result {
            case .success(let response):
                switch response {
                case .success(let data, let statusCode):
                    if let data = data {
                        let responseDataError = self.responseHandler.parseResponseDecode(data: data, modelType: modelType)
                        callCompletion(responseDataError.model, statusCode, nil)
                    } else {
                        callCompletion(nil, statusCode, nil)
                    }
                }
            case .failure(let error):
                switch error {
                case .invalidResponse(let data, let statusCode):
                    if let data = data {
                        let responseDataError = self.responseHandler.parseResponseDecode(data: data, modelType: modelType)
                        callCompletion(responseDataError.model, statusCode, DataError.error(responseDataError.model.debugDescription))
                    } else {
                        callCompletion(nil, statusCode, error)
                    }
                default:
                    callCompletion(nil, nil, error)
                }
            }
        }
        return request
    }
    
    static func isValidHttp(code: HttpStatusCode?) -> Bool {
        guard let code = code, 200 ... 299 ~= code else {
            return false
        }
        return true
    }
    
    struct DashboardEndPoint: EndPointType {
        var path: String {
            return "/api/v1/dashboardNew"
        }
        var baseURL: String {
            return SERVER_BASE_URL
        }
        var method: HTTPMethods {
            return .get
        }
        var headers: [String: String]? {
            return ["Authorization": "Bearer \(APIManager.shared.authToken)"]
        }
    }
}
