//
//  HTTP.swift
//  QRApp
//
//  Created by Ville Välimaa on 17/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import Foundation
import Result

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

/// Generic HTTP response handler which gives the request data and
/// response code as parameters and expect Result type as return value.
///
public typealias HTTPResponse = (data: Data, response: URLResponse)

class HTTPService {
    
    let session: URLSession
    
    public init() {
        session = URLSession(configuration: .default)
    }
    
    /// Creates URLRequest.
    ///
    /// - Parameter method: HTTP method.
    /// - Parameter url: HTTP URL for the request.
    /// - Parameter body: Body of the HTTP request.
    ///
    private func createRequest(_ method: HTTPMethod, url: URL, body: String? = nil) -> URLRequest {
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
    func startHTTPRequest(_ method: HTTPMethod, url: URL?, body: String? = nil) -> AsyncOperation<HTTPResponse> {
        guard let url = url else {
            return AsyncOperation(error: NSError())
        }
        return AsyncOperation { [weak self] complete in
            guard let sself = self else {
                complete(.failure(NSError()))
                return
            }
            
            sself.session.dataTask(with: sself.createRequest(method, url: url, body: body))
            { data, response, error in
                guard let data = data,
                    let response = response else {
                    complete(.failure((error as NSError?) ?? NSError()))
                    return
                }
                complete(.success(HTTPResponse(data, response)))
            }.resume()
        }
    }
    
    /// Wrapper for GET request.
    ///
    func GET(url: URL?) -> AsyncOperation<HTTPResponse> {
        return startHTTPRequest(.GET, url: url)
    }
    
    /// Wrapper for POST request.
    ///
    func POST(url: URL?, body: String) -> AsyncOperation<HTTPResponse> {
        return startHTTPRequest(.POST, url: url, body: body)
    }
    
    /// Wrapper for PUT request.
    ///
    func PUT(url: URL?, body: String) -> AsyncOperation<HTTPResponse> {
        return startHTTPRequest(.PUT, url: url, body: body)
    }
    
    /// Wrapper for DELETE request.
    ///
    func DELETE(url: URL?, body: String) -> AsyncOperation<HTTPResponse> {
        return startHTTPRequest(.DELETE, url: url, body: body)
    }
    
    /// Abstraction for JSON requests which return AsyncOperation with dictionary.
    ///
    func jsonRequest(_ url: URL?) -> AsyncOperation<[String : Any]> {
        return GET(url: url).flatMap { httpResponse in
            AsyncOperation { complete in
                do {
                    let result = try JSONSerialization.jsonObject(with: httpResponse.data, options: []) as? [String : Any]
                    guard let r = result else {
                        return complete(.failure(NSError()))
                    }
                    return complete(.success(r))
                } catch {
                    return complete(.failure(NSError()))
                }
            }
        }
    }
}
