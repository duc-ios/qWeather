//
//  DetailDataStore.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Combine
import Foundation

final class DetailDataStore: BaseDataStore {
    private var cancellables = Set<AnyCancellable>()
    enum Event: Equatable {
        enum View: Equatable {
            case loading(Bool),
                 alert(title: String, message: String),
                 error(AppError),
                 currentWeather(WeatherModel)
        }
        
        case view(View)
    }

    @Published var event: Event?

    var city: CityModel!

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

    override init() {
        super.init()

        $event
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: reduce)
            .store(in: &cancellables)
    }

    func reduce(_ event: Event?) {
        guard case .view(let event) = event else { return }
        switch event {
        case .loading(let isLoading):
            self.isLoading = isLoading
        case .alert(let title, let message):
            alertTitle = title
            alertMessage = message
            displayAlert = true
        case .error(let error):
            self.event = .view(.alert(title: error.title, message: error.message))
        case .currentWeather(let weather):
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
