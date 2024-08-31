//
//  HomeDataStore.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Combine
import Foundation

// MARK: - HomeDataStore

final class HomeDataStore: BaseDataStore {
    enum Event: Equatable {
        case loading(Bool),
             alert(title: String, message: String),
             error(AppError),
             greeting(String),
             search(String),
             savedCities([CityModel]),
             cities([CityModel])
    }

    @Published var event: Event?

    var cancellables = Set<AnyCancellable>()

    @Published var greeting = ""
    @Published var keyword = ""
    @Published var isSearching = false
    @Published var savedCities = [CityModel]()
    @Published var cities = [CityModel]()

    override init() {
        super.init()

        $keyword
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] in
                self?.event = .search($0)
            }
            .store(in: &cancellables)

        $event
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: reduce)
            .store(in: &cancellables)
    }

    func reduce(_ event: Event?) {
        switch event {
        case .loading(let isLoading):
            self.isLoading = isLoading
        case .alert(let title, let message):
            alertTitle = title
            alertMessage = message
            displayAlert = true
        case .error(let error):
            self.event = .alert(title: error.title, message: error.message)
        case .greeting(let greeting):
            self.greeting = greeting
        case .savedCities(let cities):
            savedCities = cities
        case .cities(let cities):
            self.cities = cities
        default:
            break
        }
    }
}
