//
//  BaseDataStore.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation

// MARK: - BaseDataStore

class BaseDataStore: ObservableObject {
    @Published var isLoading = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var displayAlert = false
}
