//
//  HomeConfigurator.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation

extension HomeView {
    func configured(
    ) -> HomeView {
        var view = self
        let presenter = HomePresenter(view: view)
        let interactor = HomeInteractor(presenter: presenter, database: RealmDatabase())
        view.interactor = interactor
        return view
    }
}
