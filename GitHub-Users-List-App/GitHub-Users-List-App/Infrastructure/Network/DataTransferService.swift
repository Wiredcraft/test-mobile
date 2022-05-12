//
//  DataTransferService.swift
//  GitHub-Users-List-App
//
//  Created by 邹奂霖 on 2022/5/6.
//

import Foundation
import UserNotifications
import UIKit

public enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}

public protocol DataTransferService {
    typealias CompletionHandler<T> = (Result<T,DataTransferError>) -> Void

    /// Do the network request with ResponseRequestable and pass the result by completion
    /// - Parameters:
    ///   - endpoint: ResponseRequestable of specific pass
    ///   - completion: closure for passing result
    /// - Returns: NetworkCancellable
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E, completion: @escaping CompletionHandler<T>) -> NetworkCancellable? where E.Response == T
}


public protocol DataTransferErrorResolver {
    func resolve(error: NetworkError) -> Error
}

/// Interface for decoder which is made for decode reponse
public protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

public protocol DataTransferErrorLogger {
    func log(error: Error)
}

public final class DefaultDataTransferService {
    private let networkService: NetworkService
    private let errorResolver: DataTransferErrorResolver
    private let errorLogger: DataTransferErrorLogger

    public init(with networkService: NetworkService, errorResolver: DataTransferErrorResolver = DefaultDataTransferErrorResolver(), errorLogger: DataTransferErrorLogger = DefaultDataTransferErrorLogger()) {
        self.networkService = networkService
        self.errorResolver = errorResolver
        self.errorLogger = errorLogger
    }

}

extension DefaultDataTransferService: DataTransferService {
    public func request<T, E>(with endpoint: E, completion: @escaping CompletionHandler<T>) -> NetworkCancellable? where T : Decodable, T == E.Response, E : ResponseRequestable {
        return self.networkService.request(endPoint: endpoint) { result in
            switch result {
                case .success(let data):
                    let result: Result<T, DataTransferError> = self.decode(data: data, decoder: endpoint.responseDecoder)
                    DispatchQueue.main.async {
                        return completion(result)
                    }
                case .failure(let error):
                    self.errorLogger.log(error: error)
                    let error = self.resolve(networkError: error)
                    DispatchQueue.main.async {
                        return completion(.failure(error))
                    }
            }
        }
    }

    /// Decode data to model or return DataTransferError if failed
    /// - Parameters:
    ///   - data: response data
    ///   - decoder: instance of ResponseDecoder
    /// - Returns: Result
    private func decode<T: Decodable>(data: Data?, decoder: ResponseDecoder) -> Result<T, DataTransferError> {
        do {
            guard let data = data else {
                return .failure(.noResponse)
            }
            let result:T = try decoder.decode(data)
            return .success(result)
        } catch {
            self.errorLogger.log(error: error)
            return .failure(.parsing(error))
        }
    }

    /// resolve NetworkError to DataTransferError
    private func resolve(networkError error: NetworkError) -> DataTransferError {
        let resolvedError = self.errorResolver.resolve(error: error)
        return resolvedError is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(resolvedError)
    }
}


/// Default implementation of `DataTransferErrorLogger`
public final class DefaultDataTransferErrorLogger: DataTransferErrorLogger {
    public init() {}

    public func log(error: Error) {
        printIfDebug("--------")
        printIfDebug("\(error)")
    }
}

/// Default implementation of `DataTransferErrorResolver
public class DefaultDataTransferErrorResolver: DataTransferErrorResolver {
    public init() {}
    public func resolve(error: NetworkError) -> Error {
        return error
    }
}
/// Default implementation of `ResponseDecoder
public class JSONResponseDecoder: ResponseDecoder {
    private let jsonDecoder = JSONDecoder()
    public init() {}
    public func decode<T>(_ data: Data) throws -> T where T : Decodable {
        return try jsonDecoder.decode(T.self
                                      , from: data)
    }
}
