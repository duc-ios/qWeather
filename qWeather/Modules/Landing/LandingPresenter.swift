//
//  LandingPresenter.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import UIKit

protocol LandingPresentationLogic {
    func presentIsLoading(isLoading: Bool)
    func presentError(response: Landing.ShowError.Response)
    func presentHomeOrOnBoarding(response: Landing.GetCities.Response)
}

class LandingPresenter {
    init(view: any LandingDisplayLogic) {
        self.view = view
    }

    private var view: LandingDisplayLogic
}

extension LandingPresenter: LandingPresentationLogic {
    func presentIsLoading(isLoading: Bool) {
        Task { @MainActor in
            view.event = .view(.loading(isLoading))
        }
    }

    func presentError(response: Landing.ShowError.Response) {
        Task { @MainActor in
            view.event = .view(.error(response.error))
        }
    }

    func presentHomeOrOnBoarding(response _: Landing.GetCities.Response) {
        Task { @MainActor in
            view.event = .router(.homeOrOnboarding)
        }
    }
}
