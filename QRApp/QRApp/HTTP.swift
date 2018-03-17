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
public typealias HTTPResponseHandler<T> = (Data, URLResponse) -> Result<T, NSError>

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
    /// - Parameter handler: Handler for the successful request mapping data and response code into a generic type.
    ///
    func startHTTPRequest<T>(_ method: HTTPMethod, url: URL, body: String? = nil, handler: @escaping HTTPResponseHandler<T>) -> AsyncOperation<T> {
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
                complete(handler(data, response))
            }.resume()
        }
    }
    
    /// Wrapper for GET request.
    ///
    func GET<T>(url: URL, handler: @escaping HTTPResponseHandler<T>) -> AsyncOperation<T> {
        return startHTTPRequest(.GET, url: url, handler: handler)
    }
    
    /// Wrapper for POST request.
    ///
    func POST<T>(url: URL, body: String, handler: @escaping HTTPResponseHandler<T>) -> AsyncOperation<T> {
        return startHTTPRequest(.POST, url: url, body: body, handler: handler)
    }
    
    /// Wrapper for PUT request.
    ///
    func PUT<T>(url: URL, body: String, handler: @escaping HTTPResponseHandler<T>) -> AsyncOperation<T> {
        return startHTTPRequest(.PUT, url: url, body: body, handler: handler)
    }
    
    /// Wrapper for DELETE request.
    ///
    func DELETE<T>(url: URL, body: String, handler: @escaping HTTPResponseHandler<T>) -> AsyncOperation<T> {
        return startHTTPRequest(.DELETE, url: url, body: body, handler: handler)
    }
    
    /// Abstraction for JSON requests which return AsyncOperation with dictionary.
    ///
    func jsonRequest(url: URL) -> AsyncOperation<[String : Any]>{
        return GET(url: url) { data, response in
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                guard let r = result else {
                    return .failure(NSError())
                }
                return .success(r)
            } catch {
                return .failure(NSError())
            }
        }
    }
}
