//
//  Route.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import SwiftUI

enum Route: Hashable {
    case landing,
         onboarding,
         home,
         detail(CityModel)

    @ViewBuilder var destination: some View {
        switch self {
        case .landing:
            LandingView().configured()
        case .onboarding:
            OnboardingView()
        case .home:
            HomeView().configured()
        case .detail(let city):
            DetailView().configured(city: city)
        }
    }
}
