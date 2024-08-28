//
//  DetailConfigurator.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//  Created by Duc on 29/8/24.
//

import Foundation

extension DetailView {
    func configured(
        city: CityModel
    ) -> DetailView {
        var view = self
        let presenter = DetailPresenter(view: view)
        let interactor = DetailInteractor(presenter: presenter)
        view.interactor = interactor
        return view
    }
}
