//
//  OpenWeatherMapService.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation
import Moya

// MARK: - OpenWeatherMapService

enum OpenWeatherMapService {
    case weather(lat: Double, lon: Double)
}

// MARK: TargetType

extension OpenWeatherMapService: TargetType {
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
        case let .weather(lat, lon):
            return .requestParameters(parameters: [
                "lat": lat,
                "lon": lon,
                "appid": Configs.appId,
            ], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
