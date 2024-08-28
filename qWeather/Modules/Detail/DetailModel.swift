//
//  DetailModel.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation

// swiftlint:disable nesting
enum Detail {
    enum ShowError {
        struct Request {
            var error: Error
        }

        struct Response {
            var error: AppError
        }
    }
}
// swiftlint:enable nesting
