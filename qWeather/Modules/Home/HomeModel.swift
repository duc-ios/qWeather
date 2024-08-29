//
//  HomeModel.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation

// swiftlint:disable nesting
enum Home {
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

    enum GetGreeting {
        struct Request {}

        struct Response {
            var greeting: String
        }
    }
    
    enum GetSavedCities {
        struct Request {}
        
        struct Response {
            var savedCities: [CityModel]
        }
    }
    
    enum SearchCities {
        struct Request {
            var keyword: String
        }
        
        struct Response {
            var cities: [CityModel]
        }
    }
    
    enum UpdateCity {
        struct Request {
            var cityId: Int
            var isSaved: Bool
        }
        
        struct Response {
            var city: CityModel
        }
    }
}

// swiftlint:enable nesting
