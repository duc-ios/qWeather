//
//  LandingConfigurator.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//  Created by Duc on 29/8/24.
//

import Foundation

extension LandingView {
    func configured(
    ) -> LandingView {
        var view = self
        let presenter = LandingPresenter(view: view)
        let interactor = LandingInteractor(presenter: presenter, database: RealmDatabase())
        view.interactor = interactor
        return view
    }
}
