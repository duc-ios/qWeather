//
//  DetailInteractorTests.swift
//  qWeatherTests
//
//  Created by Duc on 1/9/24.
//

import Foundation
@testable import qWeather
import SwiftData
import XCTest

// MARK: - DetailInteractorTests

final class DetailInteractorTests: XCTestCase {
    private var sut: DetailBusinessLogic!
    private var presenter: DetailPresenterMock!
    private var repository: WeatherRepository!

    @MainActor override func setUp() {
        super.setUp()

        UIView.setAnimationsEnabled(false)

        presenter = DetailPresenterMock()
        repository = WeatherRepositoryMock()

        sut = DetailInteractor(
            presenter: presenter,
            repository: repository
        )
    }

    override func tearDown() {
        sut = nil
        presenter = nil
        repository = nil

        UIView.setAnimationsEnabled(true)

        super.tearDown()
    }

    func testGetCurrentWeather() {
        // Given
        let request = Detail.GetCurrentWeather.Request(city: .init(lat: 10.75, lon: 106.6667))
        let promise = expectation(description: "Present Current Weather Called")

        // When
        sut.getCurrentWeather(request: request)
        XCTAssertTrue(presenter.isLoading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self else { return }
            // Then
            XCTAssertTrue(presenter.presentCurrentWeatherCalled)
            XCTAssertFalse(presenter.isLoading)
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
}

// MARK: - DetailPresenterMock

final class DetailPresenterMock: DetailPresentationLogic {
    var isLoading = false
    var presentAlertCalled = false
    var presentErrorCalled = false
    var presentCurrentWeatherCalled = false

    func presentIsLoading(isLoading: Bool) {
        self.isLoading = isLoading
    }

    func presentAlert(response _: Detail.ShowAlert.Response) {
        presentAlertCalled = true
    }

    func presentError(response _: Detail.ShowError.Response) {
        presentErrorCalled = true
    }

    func presentCurrentWeather(response _: Detail.GetCurrentWeather.Response) {
        presentCurrentWeatherCalled = true
    }
}

// MARK: - WeatherRepositoryMock

final class WeatherRepositoryMock: WeatherRepository {
    func getCurrentWeather(lat _: Double, lon _: Double) async throws -> qWeather.WeatherModel {
        dummyWeather
    }
}
