//
//  HomeDataStore.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Combine
import Foundation

// MARK: - HomeDataStore

final class HomeDataStore: BaseDataStore<HomeEvent>, HomeDisplayLogic {
    @Published var greeting = ""
    @Published var isSearching = false
    @Published var savedCities = [CityModel]()
    @Published var cities = [CityModel]()

    override init() {
        super.init()

        $event
            .receive(on: DispatchQueue.main)
            .compactMap {
                guard case let .view(event) = $0 else { return nil }
                return event
            }
            .sink(receiveValue: reduce)
            .store(in: &cancellables)
    }

    func reduce(_ event: HomeEvent.View) {
        switch event {
        case let .loading(isLoading):
            self.isLoading = isLoading
        case let .alert(title, message):
            alertTitle = title
            alertMessage = message
            displayAlert = true
        case let .error(error):
            self.event = .view(.alert(title: error.title, message: error.message))
        case let .greeting(greeting):
            self.greeting = greeting
        case let .savedCities(cities):
            savedCities = cities
        case let .cities(cities):
            self.cities = cities
        }
    }
}
