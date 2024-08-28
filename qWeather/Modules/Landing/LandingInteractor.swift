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
    init(presenter: LandingPresentationLogic, database: RealmDatabase) {
        self.presenter = presenter
        self.database = database
    }

    private let presenter: LandingPresentationLogic
    private let database: RealmDatabase
}

extension LandingInteractor: LandingBusinessLogic {
    func showLoading(isLoading: Bool) {
        presenter.presentIsLoading(isLoading: isLoading)
    }

    func showError(request: Landing.ShowError.Request) {
        presenter.presentError(response: .init(error: .error(request.error)))
    }
    
    func getCities(request: Landing.GetCities.Request) {
        presenter.presentIsLoading(isLoading: true)
        let error = AppError.message("Cannot parse cities json")
        do {
            if let _: CityModel = try database.read(primayKey: 833) {
                presenter.presentIsLoading(isLoading: false)
                presenter.presentHomeOrOnBoarding(response: .init())
            } else {
                if let url = Bundle.main.url(forResource: "city.list.min", withExtension: "json") {
                    Task {
                        let data = try Data(contentsOf: url)
                        let cities = try [CityModel](data)
                        try database.create(cities)
                        presenter.presentIsLoading(isLoading: false)
                        presenter.presentHomeOrOnBoarding(response: .init())
                    }
                } else {
                    presenter.presentError(response: .init(error: error))
                }
            }
        } catch {
            presenter.presentError(response: .init(error: .error(error)))
        }
    }
}
