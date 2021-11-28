//
//  CustomError.swift
//  LoremPicsum
//
//  Created by LUM on 11/28/21.
//

import Foundation

enum CustomError: Error {
    case runtimeError(String)
    case networkError(String)
    
    var errorDescription: String {
        switch self {
        case .runtimeError(let errorMessage):
            return errorMessage
        case .networkError(let errorMessage):
            return errorMessage
        }
    }
}

extension Error {
    func errorMessage() -> String {
        let defaultError = "Oops! We are having a moment. Please try again later."
        guard let error = self as? CustomError else {return defaultError}
        return error.errorDescription
    }
}
