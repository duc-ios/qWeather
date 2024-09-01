//
//  LandingModel.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation

// swiftlint:disable nesting
enum Landing {
    enum ShowAlert {
        struct Request {
            var title: String
            var message: String
        }

        struct Response {
            var title: String
            var message: String
        }
    }

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
