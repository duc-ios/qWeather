//
//  LandingConfigurator.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation

extension LandingView {
    static func configured(
    ) -> LandingView {
        let store = LandingDataStore()
        let presenter = LandingPresenter(view: store)
        let interactor = LandingInteractor(presenter: presenter, repository: CityRepositoryImp())
        let view = LandingView(interactor: interactor, store: store)
        return view
    }
}
