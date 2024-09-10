//
//  LandingConfigurator.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation

extension LandingView {
    func configured(
    ) -> LandingView {
        var view = self
        let presenter = LandingPresenter(view: view.store)
        let interactor = LandingInteractor(presenter: presenter, repository: CityRepositoryImp())
        view.interactor = interactor
        return view
    }
}
