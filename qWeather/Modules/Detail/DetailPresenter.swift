//
//  DetailPresenter.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import UIKit

protocol DetailPresentationLogic {
    func presentIsLoading(isLoading: Bool)
    func presentAlert(response: Home.ShowAlert.Response)
    func presentError(response: Detail.ShowError.Response)
    func presentCurrentWeather(response: Detail.GetCurrentWeather.Response)
}

class DetailPresenter {
    init(view: any DetailDisplayLogic) {
        self.view = view
    }

    private let view: DetailDisplayLogic
}

extension DetailPresenter: DetailPresentationLogic {
    func presentIsLoading(isLoading: Bool) {
        view.store.event = .loading(isLoading)
    }
    
    func presentAlert(response: Home.ShowAlert.Response) {
        view.store.event = .alert(title: response.message, message: "")
    }

    func presentError(response: Detail.ShowError.Response) {
        view.store.event = .error(response.error)
    }
    
    func presentCurrentWeather(response: Detail.GetCurrentWeather.Response) {
        view.store.event = .currentWeather(response.weather)
    }
}
