//
//  DetailInteractor.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import SwiftUI

// MARK: - DetailBusinessLogic

protocol DetailBusinessLogic {
    func showLoading(isLoading: Bool)
    func showError(request: Detail.ShowError.Request)
    func getCurrentWeather(request: Detail.GetCurrentWeather.Request)
}

// MARK: - DetailInteractor

class DetailInteractor {
    init(presenter: DetailPresentationLogic, repository: WeatherRepository) {
        self.presenter = presenter
        self.repository = repository
    }

    private let presenter: DetailPresentationLogic
    private let repository: WeatherRepository
}

// MARK: DetailBusinessLogic

extension DetailInteractor: DetailBusinessLogic {
    func showLoading(isLoading: Bool) {
        presenter.presentIsLoading(isLoading: isLoading)
    }

    func showError(request: Detail.ShowError.Request) {
        presenter.presentError(response: .init(error: .error(request.error)))
    }

    func getCurrentWeather(request: Detail.GetCurrentWeather.Request) {
        showLoading(isLoading: true)
        let (lat, lon) = (request.city.lat, request.city.lon)
        Task {
            do {
                let weather = try await repository.getCurrentWeather(lat: lat, lon: lon)
                showLoading(isLoading: false)
                presenter.presentCurrentWeather(response: .init(weather: weather))
            } catch {
                showLoading(isLoading: false)
                showError(request: .init(error: error))
            }
        }
    }
}
