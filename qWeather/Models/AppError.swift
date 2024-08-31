//
//  AppError.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation

enum AppError: LocalizedError, Equatable {
    static func == (lhs: AppError, rhs: AppError) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription && lhs.message == rhs.message
    }

    case
        unimplemented,
        unexpected,
        badRequest,
        network,
        error(Error),
        message(String)

    var errorDescription: String? {
        message
    }

    var title: String {
        switch self {
        case .network:
            return L10n.Error.noNetwork
        default:
            return L10n.Error.somethingWentWrong
        }
    }

    var message: String {
        switch self {
        case .unimplemented:
            return L10n.Error.unimplemented
        case .unexpected:
            return L10n.Error.unexpected
        case .badRequest:
            return L10n.Error.badRequest
        case .network:
            return L10n.Error.tryAgain
        case .error(let error):
            if let error = error as? AppError {
                return error.message
            } else {
                return (error as NSError).description
            }
        case .message(let message):
            return message
        }
    }
}
