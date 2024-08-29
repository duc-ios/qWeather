//
//  DetailInteractor.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import SwiftUI

protocol DetailBusinessLogic {
    func showLoading(isLoading: Bool)
    func showError(request: Detail.ShowError.Request)
    func getCurrentWeather(request: Detail.GetCurrentWeather.Request)
}

class DetailInteractor {
    init(presenter: DetailPresentationLogic, repository: WeatherRepository) {
        self.presenter = presenter
        self.repository = repository
    }

    private let presenter: DetailPresentationLogic
    private let repository: WeatherRepository
}

extension DetailInteractor: DetailBusinessLogic {
    func showLoading(isLoading: Bool) {
        presenter.presentIsLoading(isLoading: isLoading)
    }

    func showError(request: Detail.ShowError.Request) {
        presenter.presentError(response: .init(error: .error(request.error)))
    }
    
    func getCurrentWeather(request: Detail.GetCurrentWeather.Request) {
        guard let coord = request.city.coord else {
            return showError(request: .init(error: AppError.badRequest))
        }
        Task { @MainActor in
            do {
                showLoading(isLoading: true)
                let weather = try await repository.getCurrentWeather(lat: coord.lat, lon: coord.lon)
                showLoading(isLoading: false)
                presenter.presentCurrentWeather(response: .init(weather: weather))
            } catch {
                showError(request: .init(error: error))
            }
        }
    }
}
