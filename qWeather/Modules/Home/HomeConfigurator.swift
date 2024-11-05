//
//  HomeConfigurator.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation

extension HomeView {
    static func configured(
    ) -> HomeView {
        let store = HomeDataStore()
        let presenter = HomePresenter(view: store)
        let interactor = HomeInteractor(presenter: presenter, repository: CityRepositoryImp())
        let view = HomeView(interactor: interactor, store: store)
        return view
    }
}
