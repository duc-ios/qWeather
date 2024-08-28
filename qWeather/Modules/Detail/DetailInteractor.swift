//
//  DetailInteractor.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import SwiftUI

protocol DetailBusinessLogic {
    func showLoading(isLoading: Bool)
    func showError(request: Detail.ShowError.Request)
}

class DetailInteractor {
    init(presenter: DetailPresentationLogic) {
        self.presenter = presenter
    }

    private let presenter: DetailPresentationLogic
}

extension DetailInteractor: DetailBusinessLogic {
    func showLoading(isLoading: Bool) {
        presenter.presentIsLoading(isLoading: isLoading)
    }

    func showError(request: Detail.ShowError.Request) {
        presenter.presentError(response: .init(error: .error(request.error)))
    }
}
