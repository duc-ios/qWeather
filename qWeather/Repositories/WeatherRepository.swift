//
//  WeatherRepository.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Moya
import SwiftUI

// MARK: - WeatherRepository

protocol WeatherRepository {
    /**
     Fetches the current weather data for a specified location.

     This asynchronous function retrieves the current weather information based on the provided latitude and longitude coordinates. The function uses the OpenWeatherMap API and returns a `WeatherModel` containing details such as temperature, humidity, weather conditions, and more.

     - Parameters:
     - lat: The latitude of the location for which to retrieve the weather data.
     - lon: The longitude of the location for which to retrieve the weather data.

     - Returns: A `WeatherModel` object containing the current weather data for the specified location.

     - Throws: An error if the weather data could not be retrieved, such as network issues or invalid coordinates.

     - Example:
     ```swift
     do {
        let weather = try await getCurrentWeather(lat: 37.7749, lon: -122.4194)
        print("Current temperature: \(weather.main.temp)")
     } catch {
        print("Failed to fetch weather data: \(error)")
     }
     ```
     */
    func getCurrentWeather(lat: Double, lon: Double) async throws -> WeatherModel
}

// MARK: - WeatherRepositoryImp

final class WeatherRepositoryImp: WeatherRepository {
    private let provider = MoyaProvider<OpenWeatherMapService>(plugins: [VerbosePlugin(verbose: true)])

    func getCurrentWeather(lat: Double, lon: Double) async throws -> WeatherModel {
        let weather: WeatherModel = try await provider.async.request(.weather(lat: lat, lon: lon))
        return weather
    }
}
