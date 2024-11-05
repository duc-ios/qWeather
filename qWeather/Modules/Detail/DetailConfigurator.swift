//
//  DetailConfigurator.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation

extension DetailView {
    static func configured(
        city: CityModel
    ) -> DetailView {
        let store = DetailDataStore(city: city)
        let presenter = DetailPresenter(view: store)
        let interactor = DetailInteractor(presenter: presenter, repository: WeatherRepositoryImp())
        let view = DetailView(interactor: interactor, store: store)
        return view
    }
}
