//
//  DetailConfigurator.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation

extension DetailView {
    func configured(
        city: CityModel
    ) -> DetailView {
        var view = self
        view.store.city = city
        let presenter = DetailPresenter(view: view.store)
        let interactor = DetailInteractor(presenter: presenter, repository: WeatherRepositoryImp())
        view.interactor = interactor
        return view
    }
}
