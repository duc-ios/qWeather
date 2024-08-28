//
//  DetailPresenter.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import UIKit

protocol DetailPresentationLogic {
    func presentIsLoading(isLoading: Bool)
    func presentError(response: Detail.ShowError.Response)
}

class DetailPresenter {
    init(view: any DetailDisplayLogic) {
        self.view = view
    }

    private let view: DetailDisplayLogic
}

extension DetailPresenter: DetailPresentationLogic {
    func presentIsLoading(isLoading: Bool) {
        view.store.state = .loading(isLoading)
    }

    func presentError(response: Detail.ShowError.Response) {
        view.store.state = .error(response.error)
    }
}
