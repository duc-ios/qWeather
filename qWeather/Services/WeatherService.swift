//
//  WeatherService.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation
import Moya

// MARK: - WeatherService

enum WeatherService {
    case weather(lat: Double, lon: Double)
}

// MARK: TargetType

extension WeatherService: TargetType {
    var baseURL: URL { URL(string: "https://api.openweathermap.org/data/2.5")! }
    var path: String {
        switch self {
        case .weather:
            return "/weather"
        }
    }

    var method: Moya.Method {
        switch self {
        case .weather:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .weather(let lat, let lon):
            return .requestParameters(parameters: ["lat": lat, "lon": lon, "appid": Configs.appId], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
