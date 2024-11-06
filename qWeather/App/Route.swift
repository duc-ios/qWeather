//
//  Route.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import NavigationStackBackport
import SwiftUI

// MARK: - Route

enum Route: Hashable {
    case landing,
         onboarding,
         home,
         detail(CityModel)

    @ViewBuilder
    func destination() -> some View {
        Group {
            switch self {
            case .landing:
                LandingView.configured()
            case .onboarding:
                OnboardingView()
            case .home:
                HomeView.configured()
            case let .detail(city):
                DetailView.configured(city: city)
            }
        }
    }
}

// MARK: - Router

class Router: ObservableObject {
    @Published var current: Route = .landing
    @Published var path = [Route]()

    func show(_ route: Route) {
        path.append(route)
    }

    func replace(_ route: Route) {
        if !path.isEmpty {
            path.removeLast()
        }
        path.append(route)
    }
}
