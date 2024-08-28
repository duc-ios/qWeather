//
//  LandingDataStore.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation

final class LandingDataStore: BaseDataStore {
    enum State: Equatable {
        case loading(Bool),
             error(AppError),
             homeOrOnboarding
    }

    @Published var state: State?
}
