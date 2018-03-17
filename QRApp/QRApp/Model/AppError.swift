//
//  Error.swift
//  QRApp
//
//  Created by Ville Välimaa on 17/03/2018.
//  Copyright © 2018 Ville Välimaa. All rights reserved.
//

import Foundation

public class AppError: Error {
    
    public let httpStatusCode: Int?
    public let errorDescription: String
    
    public init(errorDescription: String, httpStatusCode: Int? = nil) {
        self.httpStatusCode = httpStatusCode
        self.errorDescription = errorDescription
    }
    
    public init(error: NSError) {
        self.errorDescription = error.localizedDescription
        self.httpStatusCode = nil
    }
    
    func asNSError() -> NSError {
        // TODO: Initialize NSError properly
        //
        return NSError()
    }
    
    static func makeUnknownError() -> AppError {
        return AppError(errorDescription: "Unknown error occured!")
    }
    
    static func makeHTTPError(httpStatusCode: Int?) -> AppError {
        return AppError(errorDescription: "Could not complete network request!", httpStatusCode: httpStatusCode ?? 0)
    }
    
    static func makeCustomError(_ description: String) -> AppError {
        return AppError(errorDescription: description)
    }
}
