//
//  WeatherRepositoryTests.swift
//  qWeatherTests
//
//  Created by Duc on 1/9/24.
//

import Foundation
@testable import qWeather
import XCTest

final class WeatherRepositoryTests: XCTestCase {
    private var sut: WeatherRepository!
    
    override func setUp() {
        super.setUp()
        
        sut = WeatherRepositoryImp()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testGetCurrentWeather() {
        // given
        let lat = 10.75
        let lon = 106.6667
        let promise = expectation(description: "Current Weather Received")
        
        // when
        Task {
            do {
                let weather = try await sut.getCurrentWeather(lat: lat, lon: lon)
                // then
                XCTAssertEqual(weather.coord, CoordModel(lon: lon, lat: lat))
            } catch {
                XCTAssertTrue(false, error.localizedDescription)
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
}
