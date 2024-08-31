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
    
    enum ShowAlert {
        struct Request {
            var message: String
        }
        
        struct Response {
            var message: String
        }
    }
    
    enum GetCurrentWeather {
        struct Request {
            var city: CityModel
        }
        
        struct Response {
            var weather: WeatherModel
        }
    }
}
// swiftlint:enable nesting
