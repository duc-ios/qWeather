//
//  HomePresenter.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import UIKit

protocol HomePresentationLogic {
    func presentIsLoading(isLoading: Bool)
    func presentAlert(response: Home.ShowAlert.Response)
    func presentError(response: Home.ShowError.Response)
    func presentGreeting(response: Home.GetGreeting.Response)
    func presentSavedCities(response: Home.GetSavedCities.Response)
    func presentCities(response: Home.SearchCities.Response)
}

class HomePresenter {
    init(view: any HomeDisplayLogic) {
        self.view = view
    }

    private var view: HomeDisplayLogic
}

extension HomePresenter: HomePresentationLogic {
    func presentIsLoading(isLoading: Bool) {
        view.event = .view(.loading(isLoading))
    }
    
    func presentAlert(response: Home.ShowAlert.Response) {
        view.event = .view(.alert(title: response.title, message: response.message))
    }

    func presentError(response: Home.ShowError.Response) {
        view.event = .view(.error(response.error))
    }
    
    func presentGreeting(response: Home.GetGreeting.Response) {
        view.event = .view(.greeting(response.greeting))
    }
    
    func presentSavedCities(response: Home.GetSavedCities.Response) {
        view.event = .view(.savedCities(response.savedCities))
    }
    
    func presentCities(response: Home.SearchCities.Response) {
        view.event = .view(.cities(response.cities))
    }
}
