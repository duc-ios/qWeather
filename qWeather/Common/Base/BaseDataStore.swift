//
//  BaseDataStore.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Combine

// MARK: - BaseDataStore

class BaseDataStore<Event>: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    @Published var event: Event?
    @Published var isLoading = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var displayAlert = false
}
