//
//  UserSettings.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import SwiftUI

class UserSettings: ObservableObject {
    @AppStorage("isOnboarded") var isOnboarded: Bool = false
    @AppStorage("isLoaded") var isLoaded: Bool = false
}
