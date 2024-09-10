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
                guard case .view(let event) = $0 else { return nil }
                return event
            }
            .sink(receiveValue: reduce)
            .store(in: &cancellables)
    }

    func reduce(_ event: HomeEvent.View) {
        switch event {
        case .loading(let isLoading):
            self.isLoading = isLoading
        case .alert(let title, let message):
            alertTitle = title
            alertMessage = message
            displayAlert = true
        case .error(let error):
            self.event = .view(.alert(title: error.title, message: error.message))
        case .greeting(let greeting):
            self.greeting = greeting
        case .savedCities(let cities):
            savedCities = cities
        case .cities(let cities):
            self.cities = cities
        }
    }
}
