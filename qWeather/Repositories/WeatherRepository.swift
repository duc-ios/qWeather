//
//  TaskRepository.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import SwiftUI

// MARK: - WeatherRepository

protocol WeatherRepository {
    func get(city: CityModel) throws -> [WeatherModel]
}

// MARK: - WeatherRepository

class WeatherRepositoryImp: WeatherRepository {
    private let db: RealmDB

    init(db: RealmDB = RealmDB()) {
        self.db = db
    }
    
    func get(city: CityModel) throws -> [WeatherModel] {
        return []
    }
}
