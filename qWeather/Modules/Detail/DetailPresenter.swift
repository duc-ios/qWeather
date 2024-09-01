//
//  DetailPresenter.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import UIKit

protocol DetailPresentationLogic {
    func presentIsLoading(isLoading: Bool)
    func presentAlert(response: Detail.ShowAlert.Response)
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
        view.store.event = .view(.loading(isLoading))
    }
    
    func presentAlert(response: Detail.ShowAlert.Response) {
        view.store.event = .view(.alert(title: response.title, message: response.message))
    }

    func presentError(response: Detail.ShowError.Response) {
        view.store.event = .view(.error(response.error))
    }
    
    func presentCurrentWeather(response: Detail.GetCurrentWeather.Response) {
        view.store.event = .view(.currentWeather(response.weather))
    }
}
