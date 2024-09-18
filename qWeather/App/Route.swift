//
//  Route.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Routing
import SwiftUI

enum Route: Routable {
    case landing,
         onboarding,
         home,
         detail(CityModel)

    @ViewBuilder
    func viewToDisplay(router: Router<Route>) -> some View {
        Group {
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
        .environmentObject(router)
    }

    var navigationType: NavigationType {
        switch self {
        case .landing:
            return .push
        case .onboarding:
            return .push
        case .home:
            return .push
        case .detail:
            return .push
        }
    }
}
