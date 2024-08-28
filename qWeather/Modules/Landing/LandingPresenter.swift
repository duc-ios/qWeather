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

    private let view: LandingDisplayLogic
}

extension LandingPresenter: LandingPresentationLogic {
    func presentIsLoading(isLoading: Bool) {
        view.store.state = .loading(isLoading)
    }

    func presentError(response: Landing.ShowError.Response) {
        view.store.state = .error(response.error)
    }
    
    func presentHomeOrOnBoarding(response: Landing.GetCities.Response) {
        view.store.state = .homeOrOnboarding
    }
}
