//
//  LandingDataStore.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Combine
import Foundation

final class LandingDataStore: BaseDataStore<LandingEvent>, LandingDisplayLogic {
    override init() {
        super.init()

        $event
            .receive(on: DispatchQueue.main)
            .compactMap {
                guard case let .view(event) = $0 else { return nil }
                dump(event)
                return event
            }
            .sink(receiveValue: reduce)
            .store(in: &cancellables)
    }

    func reduce(_ event: LandingEvent.View) {
        switch event {
        case let .loading(isLoading):
            self.isLoading = isLoading
        case let .alert(title, message):
            alertTitle = title
            alertMessage = message
            displayAlert = true
        case let .error(error):
            self.event = .view(.alert(title: error.title, message: error.message))
        }
    }
}
