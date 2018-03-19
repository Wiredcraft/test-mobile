//
//  HTTP+Task.swift
//  QRApp
//
//  Created by Ville Välimaa on 17/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import Foundation

class HTTPTask {
    
    let request: URLRequest
    let session: URLSession
    
    /// Creates URLRequest.
    ///
    /// - Parameter method: HTTP method.
    /// - Parameter url: HTTP URL for the request.
    /// - Parameter body: Body of the HTTP request.
    ///
    static func createRequest(_ method: HTTPMethod, url: URL, body: String? = nil) -> URLRequest {
        return with(NSMutableURLRequest(url: url)) {
            $0.httpMethod = method.rawValue
            $0.httpBody = body?.data(using: .utf8)
        } as URLRequest
    }
    
    /// Starts HTTP request and returns AsyncOperation.
    ///
    /// - Parameter method: HTTP method.
    /// - Parameter url: HTTP URL for the request.
    /// - Parameter body: Body of the HTTP request.
    ///
    func start() -> AsyncOperation<HTTPResponse> {
        return AsyncOperation { [weak self] complete in
            guard let sself = self else {
                complete(.failure(AppError.makeUnknownError()))
                return
            }
            
            sself.session.dataTask(with: sself.request)
            { data, response, error in
                guard let data = data,
                    let r = response else {
                        complete(.failure(AppError.makeHTTPError(httpStatusCode: response?.getStatusCode())))
                        return
                }
                complete(.success(HTTPResponse(data, r)))
            }.resume()
        }
    }
    
    public init?(_ method: HTTPMethod, session: URLSession, url: URL?, body: String? = nil) {
        guard let url = url else { return nil }
        self.request = HTTPTask.createRequest(method, url: url)
        self.session = session
    }
}
