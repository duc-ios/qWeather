//
//  DetailInteractorTests.swift
//  qWeatherTests
//
//  Created by Duc on 1/9/24.
//

import Foundation
@testable import qWeather
import SwiftData
import Testing
import UIKit

// MARK: - DetailInteractorTests

final class DetailInteractorTests {
    private var sut: DetailBusinessLogic!
    private var presenter: DetailPresenterMock!
    private var repository: WeatherRepository!

    init() {
        UIView.setAnimationsEnabled(false)

        presenter = DetailPresenterMock()
        repository = WeatherRepositoryMock()

        sut = DetailInteractor(
            presenter: presenter,
            repository: repository
        )
    }

    deinit {
        sut = nil
        presenter = nil
        repository = nil

        UIView.setAnimationsEnabled(true)
    }

    @Test func getCurrentWeather() async throws {
        // Given
        let request = Detail.GetCurrentWeather.Request(city: .init(lat: 10.75, lon: 106.6667))

        // When
        sut.getCurrentWeather(request: request)
        #expect(presenter.isLoading == true)
        try await Task.sleep(for: .seconds(0.1))

        // Then
        #expect(presenter.presentCurrentWeatherCalled == true)
        #expect(presenter.isLoading == false)
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

    func presentAlert(response: Detail.ShowAlert.Response) {
        presentAlertCalled = true
    }

    func presentError(response: Detail.ShowError.Response) {
        presentErrorCalled = true
    }

    func presentCurrentWeather(response: Detail.GetCurrentWeather.Response) {
        presentCurrentWeatherCalled = true
    }
}

// MARK: - WeatherRepositoryMock

final class WeatherRepositoryMock: WeatherRepository {
    func getCurrentWeather(lat: Double, lon: Double) async throws -> qWeather.WeatherModel {
        dummyWeather
    }
}
