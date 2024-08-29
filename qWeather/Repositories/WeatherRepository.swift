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

class WeatherRepositoryImp: WeatherRepository {
    let provider = MoyaProvider<WeatherService>()

    func getCurrentWeather(lat: Double, lon: Double) async throws -> WeatherModel {
        let weather: WeatherModel = try await provider.async.request(.weather(lat: lat, lon: lon))
        return weather
    }
}
