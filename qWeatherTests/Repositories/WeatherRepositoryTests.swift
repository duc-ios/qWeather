//
//  WeatherRepositoryTests.swift
//  qWeatherTests
//
//  Created by Duc on 1/9/24.
//

import Foundation
@testable import qWeather
import Testing

final class WeatherRepositoryTests {
    private var sut: WeatherRepository!

    init() {
        sut = WeatherRepositoryImp()
    }

    deinit {
        sut = nil
    }

    @Test func getCurrentWeather() async throws {
        // given
        let lat = 10.75
        let lon = 106.6667

        // when
        let weather = try await sut.getCurrentWeather(lat: lat, lon: lon)
        // then
        #expect(weather.coord == CoordModel(lon: lon, lat: lat))
    }
}
