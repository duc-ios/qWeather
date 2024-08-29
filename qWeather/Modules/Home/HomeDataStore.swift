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
    enum State: Equatable {
        case loading(Bool),
             alert(title: String, message: String),
             error(AppError),
             greeting(String),
             search(String),
             savedCities([CityModel]),
             cities([CityModel])
    }

    var cancellables = Set<AnyCancellable>()

    @Published var state: State?

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
                self?.state = .search($0)
            }
            .store(in: &cancellables)
    }
}
