//
//  TaskRepository.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Moya
import SwiftUI

// MARK: - WeatherRepository

protocol WeatherRepository {
    func getCurrentWeather(lat: Double, lon: Double) async throws -> WeatherModel
}

// MARK: - WeatherRepositoryImp

final class WeatherRepositoryImp: WeatherRepository {
    let provider = MoyaProvider<WeatherService>(plugins: [VerbosePlugin(verbose: true)])

    func getCurrentWeather(lat: Double, lon: Double) async throws -> WeatherModel {
        let weather: WeatherModel = try await provider.async.request(.weather(lat: lat, lon: lon))
        return weather
    }
}

// MARK: - VerbosePlugin

struct VerbosePlugin: PluginType {
    let verbose: Bool

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if verbose {
            logger.debug("\(request.httpMethod ?? ""): \(request.url?.absoluteString ?? "")")
            if let body = request.httpBody,
               let str = String(data: body, encoding: .utf8)
            {
                logger.debug("BODY: \(str))")
            }
        }
        return request
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let body):
            if verbose {
                logger.debug("RESPONSE:")
                if let json = try? JSONSerialization.jsonObject(with: body.data, options: .mutableContainers) {
                    debugPrint(json)
                } else {
                    let response = String(data: body.data, encoding: .utf8)!
                    logger.debug("\(response)")
                }
            }
        case .failure:
            break
        }
    }
}
