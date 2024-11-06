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
        unauthenticated,
        badRequest,
        notFound,
        network,
        error(Error),
        other(code: Int = -1, message: String)

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
        case .unauthenticated:
            return L10n.Error.unauthenticated
        case .badRequest:
            return L10n.Error.badRequest
        case .notFound:
            return L10n.notFound
        case .network:
            return L10n.Error.tryAgain
        case let .error(error):
            if let error = error as? AppError {
                return error.message
            } else {
                return (error as NSError).description
            }
        case let .other(code, message):
            #if DEBUG
                return "\(code): \(message)"
            #else
                return message
            #endif
        }
    }
}
