//
//  AppView.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import SwiftUI

// MARK: - AppView

struct AppView: View {
    @ObservedObject var router = Router()
    @ObservedObject var userSettings = UserSettings()

    var body: some View {
        NavigationStack(path: $router.path) {
            ProgressView()
                .navigationDestination(for: Route.self) {
                    switch $0 {
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
                .onAppear {
                    if userSettings.isLoaded {
                        if userSettings.isOnboarded {
                            router.pop(to: .home)
                        } else {
                            router.pop(to: .onboarding)
                        }
                    } else {
                        router.pop(to: .landing)
                    }
                }
        }
        .tint(Color.gradient)
        .environmentObject(router)
        .environmentObject(userSettings)
    }
}

extension UINavigationController {
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
