//
//  DetailDataStore.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Combine
import Foundation

final class DetailDataStore: BaseDataStore<DetailEvent>, DetailDisplayLogic {
    let city: CityModel

    @Published var icon: URL?
    @Published var name: String = ""
    @Published var temp: String = ""
    @Published var feelsLike: String = ""
    @Published var descriptions: String = ""
    @Published var lh: String = ""
    @Published var sunrise: String = ""
    @Published var sunset: String = ""
    @Published var wind: String = ""
    @Published var pressure: String = ""
    @Published var humidity: String = ""
    @Published var visibility: String = ""

    init(city: CityModel) {
        self.city = city
        super.init()

        $event
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: reduce)
            .store(in: &cancellables)
    }

    func reduce(_ event: DetailEvent?) {
        guard case let .view(event) = event else { return }
        switch event {
        case let .loading(isLoading):
            self.isLoading = isLoading
        case let .alert(title, message):
            alertTitle = title
            alertMessage = message
            displayAlert = true
        case let .error(error):
            self.event = .view(.alert(title: error.title, message: error.message))
        case let .currentWeather(weather):
            icon = weather.weather.first?.icon
            name = weather.name
            temp = weather.main.temp
            feelsLike = weather.main.feelsLike
            descriptions = weather.weather.map { $0.description }.joined(separator: ". ")
            lh = L10n.Detail.lh(weather.main.tempMin, weather.main.tempMax)
            sunrise = L10n.Detail.sunrise(weather.sys.sunrise.formatted(date: .omitted, time: .shortened))
            sunset = L10n.Detail.sunset(weather.sys.sunset.formatted(date: .omitted, time: .shortened))
            wind = L10n.Detail.wind(weather.wind.speed, weather.wind.deg)
            pressure = L10n.Detail.pressure(weather.main.pressure)
            humidity = L10n.Detail.humidity(weather.main.humidity)
            visibility = L10n.Detail.visibility(weather.visibility)
        }
    }
}
