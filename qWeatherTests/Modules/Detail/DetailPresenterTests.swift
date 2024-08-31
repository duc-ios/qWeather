//
//  DetailPresenterTests.swift
//  qWeatherTests
//
//  Created by Duc on 1/9/24.
//

import Combine
import Foundation
@testable import qWeather
import XCTest

// MARK: - DetailPresenterTests

final class DetailPresenterTests: XCTestCase {
    private var sut: DetailPresenter!
    private var view: DetailViewMock!
    
    override func setUp() {
        super.setUp()
        
        UIView.setAnimationsEnabled(false)
        
        view = DetailViewMock()
        sut = DetailPresenter(view: view)
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testGetGreetings() {
        // Given
        let response = Detail.GetCurrentWeather.Response(weather: dummyWeather)
        
        // When
        sut.presentCurrentWeather(response: response)
        
        // Then
        XCTAssertEqual(view.store.name, dummyWeather.name)
        XCTAssertEqual(view.store.temp, dummyWeather.main.temp)
    }
    
    func testDisplayError() {
        // Given
        let error = AppError.unexpected
        
        // When
        sut.presentError(response: .init(error: error))
        
        // Then
        XCTAssertEqual(view.store.alertTitle, error.title)
        XCTAssertEqual(view.store.alertMessage, error.message)
        XCTAssertEqual(view.store.displayAlert, true)
    }
}

// MARK: - DetailViewMock

final class DetailViewMock: DetailDisplayLogic {
    var store = DetailDataStore()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        store.$event.sink { [weak self] in
            guard let self else { return }
            switch $0 {
            case .error(let error):
                store.alertTitle = error.title
                store.alertMessage = error.message
                store.displayAlert = true
            case .currentWeather(let weather):
                store.name = weather.name
                store.temp = weather.main.temp
            default:
                break
            }
        }.store(in: &cancellables)
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
