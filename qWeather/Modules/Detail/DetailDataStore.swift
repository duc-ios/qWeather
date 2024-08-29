//
//  DetailDataStore.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation

final class DetailDataStore: BaseDataStore {
    enum State: Equatable {
        case loading(Bool),
             error(AppError),
             currentWeather(WeatherModel)
    }

    var city: CityModel!
    @Published var state: State?
    @Published var weather: WeatherModel?
}
