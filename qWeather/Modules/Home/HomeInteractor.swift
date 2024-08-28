//
//  HomeInteractor.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Combine
import SwiftUI

// MARK: - HomeBusinessLogic

protocol HomeBusinessLogic {
    func showLoading(isLoading: Bool)
    func showAlert(request: Home.ShowAlert.Request)
    func showError(request: Home.ShowError.Request)
    func getGreeting(request: Home.GetGreeting.Request)
    func getSavedCities(request: Home.GetSavedCities.Request)
    func searchCities(request: Home.SearchCities.Request)
    func updateCity(request: Home.UpdateCity.Request)
}

// MARK: - HomeInteractor

class HomeInteractor {
    init(presenter: HomePresentationLogic, database: RealmDatabase) {
        self.presenter = presenter
        self.database = database
        
        getSavedCities(request: .init())
    }

    private let presenter: HomePresentationLogic
    private let database: RealmDatabase

    private let greeting = Greeting()
    private var cities = [CityModel]()
    private var savedCities = [CityModel]()
}

// MARK: HomeBusinessLogic

extension HomeInteractor: HomeBusinessLogic {
    func showLoading(isLoading: Bool) {
        presenter.presentIsLoading(isLoading: isLoading)
    }

    func showAlert(request: Home.ShowAlert.Request) {
        presenter.presentAlert(response: .init(message: request.message))
    }

    func showError(request: Home.ShowError.Request) {
        presenter.presentError(response: .init(error: .error(request.error)))
    }

    func getGreeting(request: Home.GetGreeting.Request) {
        presenter.presentGreeting(response: .init(greeting: greeting.text(date: Date())))
    }

    func getSavedCities(request: Home.GetSavedCities.Request) {
        do {
            savedCities = try database.read(predicateFormat: "isSaved = true")
            presenter.presentCities(response: .init(savedCities: savedCities, cities: cities))
        } catch {
            presenter.presentError(response: .init(error: .error(error)))
        }
    }

    func searchCities(request: Home.SearchCities.Request) {
        if request.keyword.isBlank {
            cities = []
            presenter.presentCities(response: .init(savedCities: savedCities, cities: cities))
        } else {
            do {
                cities = try database.read(predicateFormat: "name CONTAINS[c] %@", args: request.keyword)
                presenter.presentCities(response: .init(savedCities: savedCities, cities: cities))
            } catch {
                presenter.presentError(response: .init(error: .error(error)))
            }
        }
    }

    func updateCity(request: Home.UpdateCity.Request) {
        do {
            if let city: CityModel = try database.read(primayKey: request.cityId) {
                try database.update({
                    city.isSaved = request.isSaved
                })
                if let idx = cities.firstIndex(where: { $0.id == city.id }) {
                    cities[idx] = city
                }
                getSavedCities(request: .init())
                presenter.presentCities(response: .init(savedCities: savedCities, cities: cities))
            } else {
                presenter.presentError(response: .init(error: .message(L10n.notFound)))
            }
        } catch {
            presenter.presentError(response: .init(error: .error(error)))
        }
    }
}
