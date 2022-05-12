//
//  NetworkService.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/6.
//

import Foundation
import UIKit

public enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case URLGeneration
}


/// NetworkCancellable provids interface to network task to cancell the task.
public protocol NetworkCancellable {
    /// Cancel
    /// Cancel the network task in the implementation
    func cancel()
}

extension URLSessionTask: NetworkCancellable { }

/// NetworkService
/// Interface for application's network module
public protocol NetworkService {
    typealias CompletionHandler = (Result<Data?, NetworkError>) -> Void
    /// Request with Requestable and pass response through completion
    /// - Parameters:
    ///   - endPoint: Requestable instance
    ///   - completion: pass response result throught Data?, NetworkError
    /// - Returns: Instance of NetworkCancellable
    func request(endPoint: Requestable, completion: @escaping CompletionHandler) -> NetworkCancellable?
}

public protocol NetworkSessionManager {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    /// Do the network request and pass result through completion Handler
    /// - Parameters:
    ///   - request: instance of URLRequest
    ///   - completion: pass result through completion Handler
    /// - Returns: instance of NetworkCancellable
    func request(_ request: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancellable
}

public protocol NetworkErrorLogger {
    /// log the information of Request
    /// - Parameter request: target request
    func log(request: URLRequest)
    /// Log the information of response
    /// - Parameters:
    ///   - data: response data
    ///   - response: instance of URLResponse
    func log(responseData data: Data?, response: URLResponse?)
    /// Log the information of error
    /// - Parameter error: error
    func log(error: Error)
}

public final class DefaultNetworkService {
    private let config: NetworkConfigurable
    private let sessionManager: NetworkSessionManager
    private let logger: NetworkErrorLogger

    public init(config: NetworkConfigurable,
                sessionManager: NetworkSessionManager = DefaultNetworkSessionManager(),
                logger: NetworkErrorLogger = DefaultNetworkErrorLogger()) {
        self.sessionManager = sessionManager
        self.config = config
        self.logger = logger
    }

    /// Do the network request through sessionManager and pass the result through completionHandler
    /// - Parameters:
    ///   - request: Instance of URLRequest
    ///   - completion: Pass the result through completion handler
    /// - Returns: instance of Network Cancellable
    private func request(request: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancellable {
        let sessionDataTask = sessionManager.request(request) { [weak self] data, response, requestError in
            guard let self = self else { return }
            if let requestError = requestError {
                var error: NetworkError
                if let response = response as? HTTPURLResponse {
                    error = .error(statusCode: response.statusCode, data: data)
                } else {
                    error = self.resolve(error: requestError)
                }
                self.logger.log(error: error)
                completion(.failure(error))
            } else {
                self.logger.log(responseData: data, response: response)
                completion(.success(data))
            }
        }
        logger.log(request: request)

        return sessionDataTask
    }

    /// Resolve error to NetworkError
    /// - Parameter error: error from network response
    /// - Returns: resolved NetworkError
    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        case .cancelled: return .cancelled
        default: return .generic(error)
        }
    }
}

extension DefaultNetworkService: NetworkService {
    public func request(endPoint: Requestable, completion: @escaping CompletionHandler) -> NetworkCancellable? {
        do {
            let urlRequest = try endPoint.urlRequest(with: config)
            return request(request: urlRequest, completion: completion)
        } catch {
            completion(.failure(.URLGeneration))
            return nil
        }
    }
}


/// Default implementation for `NetworkSessionManager`
public class DefaultNetworkSessionManager: NetworkSessionManager {
    public init() { }
    public func request(_ request: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancellable {
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
        return task
    }
}

/// Default implementation for `NetworkErrorLogger`
public final class DefaultNetworkErrorLogger: NetworkErrorLogger {
    public init() { }

    public func log(request: URLRequest) {
        print("-------------")
        print("request: \(request.url!)")
        print("headers: \(request.allHTTPHeaderFields!)")
        print("method: \(request.httpMethod!)")
        if let httpBody = request.httpBody, let result = ((try? JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: AnyObject]) as [String: AnyObject]??) {
            printIfDebug("body: \(String(describing: result))")
        } else if let httpBody = request.httpBody, let resultString = String(data: httpBody, encoding: .utf8) {
            printIfDebug("body: \(String(describing: resultString))")
        }
    }

    public func log(responseData data: Data?, response: URLResponse?) {
        guard let data = data else { return }
        if let httpResponse = response as? HTTPURLResponse, let allHeaderFields = httpResponse.allHeaderFields as? [String: Any] {
            printIfDebug("responseHeaders: \(String(describing: allHeaderFields))")
        }
        if let dataDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            printIfDebug("responseData: \(String(describing: dataDict))")
        }
    }

    public func log(error: Error) {
        printIfDebug("\(error)")
    }
}
extension NetworkError {
    public var isNotFoundError: Bool { return hasStatusCode(404) }

    /// Estimate whether a `NetworkError` has specific statusCode
    /// - Parameter codeError: specific statusCode you want esimate
    /// - Returns: result
    public func hasStatusCode(_ codeError: Int) -> Bool {
        switch self {
        case let .error(code, _):
            return code == codeError
        default: return false
        }
    }
}

extension Dictionary where Key == String {
    func prettyPrint() -> String {
        var string: String = ""
        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            if let nstr = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                string = nstr as String
            }
        }
        return string
    }
}

func printIfDebug(_ string: String) {
    #if DEBUG
    print(string)
    #endif
}
