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
        case loading(Bool),
             error(AppError),
             homeOrOnboarding
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

    func reduce(_ event: LandingDataStore.Event?) {
        switch event {
        case .loading(let isLoading):
            self.isLoading = isLoading
        case .error(let error):
            alertTitle = error.title
            alertMessage = error.message
            displayAlert = true
        default:
            break
        }
    }
}
