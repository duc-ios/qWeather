//
//  LandingDataStore.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Combine
import Foundation

final class LandingDataStore: BaseDataStore {
    enum Event: Equatable {
        enum View: Equatable {
            case loading(Bool),
                 alert(title: String, message: String),
                 error(AppError)
        }

        enum Router: Equatable {
            case homeOrOnboarding
        }

        case view(View), router(Router)
    }

    @Published var event: Event?

    private var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()

        $event
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: reduce)
            .store(in: &cancellables)
    }

    func reduce(_ event: Event?) {
        guard case .view(let event) = event else { return }
        switch event {
        case .loading(let isLoading):
            self.isLoading = isLoading
        case .alert(let title, let message):
            alertTitle = title
            alertMessage = message
            displayAlert = true
        case .error(let error):
            self.event = .view(.alert(title: error.title, message: error.message))
        }
    }
}
