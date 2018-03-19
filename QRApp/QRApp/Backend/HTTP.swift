//
//  HTTP.swift
//  QRApp
//
//  Created by Ville Välimaa on 17/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import Foundation

/// HTTP Method types
///
/// - seealso: RFC 2616 - Hypertext Transfer Protocol -- HTTP/1.1
/// https://tools.ietf.org/html/rfc2616
///
enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    case OPTIONS
    case HEAD
    case TRACE
    case PATCH
    case CONNECT
}

/// Generic HTTP response type which contains the response payload and
/// other response data as parameters.
///
typealias HTTPResponse = (data: Data, response: URLResponse)

class HTTPService {
    
    private let session = URLSession(configuration: .default)
    
    func startHTTPRequest(_ method: HTTPMethod, url: URL?, body: String? = nil) -> AsyncOperation<HTTPResponse> {
        guard let task = HTTPTask(method, session: session, url: url, body: body) else {
            return AsyncOperation(error: AppError.makeUnknownError())
        }
        return task.start()
    }
    
    /// Quick wrapper for GET request.
    ///
    func GET(url: URL?) -> AsyncOperation<HTTPResponse> {
        return startHTTPRequest(.GET, url: url)
    }
    
    /// Quick wrapper for POST request.
    ///
    func POST(url: URL?, body: String) -> AsyncOperation<HTTPResponse> {
        return startHTTPRequest(.POST, url: url, body: body)
    }
    
    /// Quick wrapper for PUT request.
    ///
    func PUT(url: URL?, body: String) -> AsyncOperation<HTTPResponse> {
        return startHTTPRequest(.PUT, url: url, body: body)
    }
    
    /// Quick wrapper for DELETE request.
    ///
    func DELETE(url: URL?, body: String) -> AsyncOperation<HTTPResponse> {
        return startHTTPRequest(.DELETE, url: url, body: body)
    }
    
    /// Abstraction for JSON requests which return AsyncOperation with dictionary.
    ///
    func jsonRequest(method: HTTPMethod = .GET, _ url: URL?, body: String? = nil) -> AsyncOperation<[String : Any]> {
        return startHTTPRequest(method, url: url, body: body).flatMap { httpResponse in
            AsyncOperation { complete in
                do {
                    let result = try JSONSerialization.jsonObject(with: httpResponse.data, options: []) as? [String : Any]
                    guard let r = result else {
                        return complete(.failure(AppError.makeCustomError("JSON parsing failure")))
                    }
                    return complete(.success(r))
                } catch {
                    return complete(.failure(AppError.makeCustomError("JSON parsing failure")))
                }
            }
        }
    }
}
