//
//  LandingModel.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation

// swiftlint:disable nesting
enum Landing {
    enum ShowError {
        struct Request {
            var error: Error
        }

        struct Response {
            var error: AppError
        }
    }

    enum GetCities {
        struct Request {}

        struct Response {}
    }
}

// swiftlint:enable nesting
