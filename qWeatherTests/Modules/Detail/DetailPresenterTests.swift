//
//  DetailPresenterTests.swift
//  qWeatherTests
//
//  Created by Duc on 1/9/24.
//

import Combine
import Foundation
@testable import qWeather
import Testing
import UIKit

// MARK: - DetailPresenterTests

final class DetailPresenterTests {
    private var sut: DetailPresenter!
    private var view: DetailViewMock!

    init() {
        UIView.setAnimationsEnabled(false)

        view = DetailViewMock()
        sut = DetailPresenter(view: view)
    }

    deinit {
        sut = nil
        view = nil

        UIView.setAnimationsEnabled(true)
    }

    @Test func getCurrentWeather() async throws {
        // Given
        let response = Detail.GetCurrentWeather.Response(weather: dummyWeather)

        // When
        sut.presentCurrentWeather(response: response)
        try await Task.sleep(nanoseconds: 100_000_000)

        // Then
        #expect(view.name == dummyWeather.name)
        #expect(view.temp == dummyWeather.main.temp)
    }

    @Test func displayError() async throws {
        // Given
        let error = AppError.unexpected

        // When
        sut.presentError(response: .init(error: error))
        try await Task.sleep(nanoseconds: 100_000_000)

        // Then
        #expect(view.alertTitle == error.title)
        #expect(view.alertMessage == error.message)
        #expect(view.displayAlert == true)
    }
}

// MARK: - DetailViewMock

final class DetailViewMock: DetailDisplayLogic {
    var alertTitle: String?
    var alertMessage: String?
    var displayAlert = false
    var name: String?
    var temp: String?

    var event: DetailEvent? {
        didSet {
            guard case let .view(event) = event else { return }
            switch event {
            case let .alert(title, message):
                alertTitle = title
                alertMessage = message
                displayAlert = true
            case let .error(error):
                alertTitle = error.title
                alertMessage = error.message
                displayAlert = true
            case let .currentWeather(weather):
                name = weather.name
                temp = weather.main.temp
            default:
                break
            }
        }
    }
}

let dummyWeather = {
    let json = """
    {
        "coord": {
            "lon": 106.6667,
            "lat": 10.75
        },
        "weather": [
            {
                "id": 801,
                "main": "Clouds",
                "description": "few clouds",
                "icon": "02n"
            }
        ],
        "base": "stations",
        "main": {
            "temp": 298.75,
            "feels_like": 299.66,
            "temp_min": 298.16,
            "temp_max": 298.75,
            "pressure": 1006,
            "humidity": 88,
            "sea_level": 1006,
            "grnd_level": 1006
        },
        "visibility": 8000,
        "wind": {
            "speed": 1.03,
            "deg": 30
        },
        "clouds": {
            "all": 20
        },
        "dt": 1725132697,
        "sys": {
            "type": 2,
            "id": 2093009,
            "country": "VN",
            "sunrise": 1725144231,
            "sunset": 1725188596
        },
        "timezone": 25200,
        "id": 1566083,
        "name": "Ho Chi Minh City",
        "cod": 200
    }
    """
    return try! WeatherModel(data: json.data(using: .utf8)!)
}()
