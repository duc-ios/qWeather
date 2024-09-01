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
    init(presenter: HomePresentationLogic, repository: CityRepository) {
        self.presenter = presenter
        self.repository = repository

        do {
            try repository.observe("isSaved = true", sorts: [("country", true), ("name", true)]) { [weak self] in
                guard let self else { return }
                switch $0 {
                case .success(let cities):
                    self.savedCities = Array(cities)
                    presenter.presentSavedCities(response: .init(savedCities: self.savedCities))
                case .failure(let error):
                    presenter.presentError(response: .init(error: error))
                }
            }
        } catch {
            showError(request: .init(error: error))
        }
    }

    private let presenter: HomePresentationLogic
    private let repository: CityRepository

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
        presenter.presentAlert(response: .init(title: request.title, message: request.message))
    }

    func showError(request: Home.ShowError.Request) {
        presenter.presentError(response: .init(error: .error(request.error)))
    }

    func getGreeting(request: Home.GetGreeting.Request) {
        presenter.presentGreeting(response: .init(greeting: greeting.text(date: request.date)))
    }

    func getSavedCities(request: Home.GetSavedCities.Request) {
        do {
            savedCities = try repository.read("isSaved = true", sorts: [("country", true), ("name", true)])
            presenter.presentCities(response: .init(cities: cities))
        } catch {
            showError(request: .init(error: error))
        }
    }

    func searchCities(request: Home.SearchCities.Request) {
        if request.keyword.isBlank {
            cities = []
            presenter.presentCities(response: .init(cities: cities))
        } else {
            do {
                cities = try repository.read(String(format: "name CONTAINS[c] '%@'", request.keyword), sorts: [("country", true), ("name", true)])
                presenter.presentCities(response: .init(cities: cities))
            } catch {
                showError(request: .init(error: error))
            }
        }
    }

    func updateCity(request: Home.UpdateCity.Request) {
        do {
            if let city: CityModel = try repository.read(primaryKey: request.cityId) {
                try repository.update {
                    city.isSaved = request.isSaved
                }
                if let idx = cities.firstIndex(where: { $0.id == city.id }) {
                    cities[idx] = city
                }
                presenter.presentCities(response: .init(cities: cities))
            } else {
                presenter.presentError(response: .init(error: .message(L10n.notFound)))
            }
        } catch {
            showError(request: .init(error: error))
        }
    }
}
