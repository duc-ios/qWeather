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
    func presentCities(response: Home.SearchCities.Response)
}

class HomePresenter {
    init(view: any HomeDisplayLogic) {
        self.view = view
    }

    private let view: HomeDisplayLogic
}

extension HomePresenter: HomePresentationLogic {
    func presentIsLoading(isLoading: Bool) {
        view.store.state = .loading(isLoading)
    }
    
    func presentAlert(response: Home.ShowAlert.Response) {
        view.store.state = .alert(title: response.message, message: "")
    }

    func presentError(response: Home.ShowError.Response) {
        view.store.state = .error(response.error)
    }
    
    func presentGreeting(response: Home.GetGreeting.Response) {
        view.store.state = .greeting(response.greeting)
    }
    
    func presentCities(response: Home.SearchCities.Response) {
        view.store.state = .cities(savedCities: response.savedCities, cities: response.cities)
    }
}
