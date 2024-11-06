//
//  LandingInteractor.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import SwiftUI

protocol LandingBusinessLogic {
    func showLoading(isLoading: Bool)
    func showError(request: Landing.ShowError.Request)
    func getCities(request: Landing.GetCities.Request)
}

class LandingInteractor {
    init(presenter: LandingPresentationLogic, repository: CityRepository) {
        self.presenter = presenter
        self.repository = repository
    }

    private let presenter: LandingPresentationLogic
    private let repository: CityRepository
}

extension LandingInteractor: LandingBusinessLogic {
    func showLoading(isLoading: Bool) {
        presenter.presentIsLoading(isLoading: isLoading)
    }

    func showError(request: Landing.ShowError.Request) {
        presenter.presentError(response: .init(error: .error(request.error)))
    }

    func getCities(request: Landing.GetCities.Request) {
        showLoading(isLoading: true)
        let error = AppError.other(message: "Cannot parse cities json")
        do {
            if let _: CityModel = try repository.read(primaryKey: 15) {
                showLoading(isLoading: false)
                presenter.presentHomeOrOnBoarding(response: .init())
            } else {
                if let url = Bundle.main.url(forResource: "city.list.min", withExtension: "json") {
                    Task {
                        let data = try Data(contentsOf: url)
                        let cities = try [CityModel](data: data)
                        try repository.create(cities)
                        showLoading(isLoading: false)
                        presenter.presentHomeOrOnBoarding(response: .init())
                    }
                } else {
                    showError(request: .init(error: error))
                }
            }
        } catch {
            showError(request: .init(error: error))
        }
    }
}
