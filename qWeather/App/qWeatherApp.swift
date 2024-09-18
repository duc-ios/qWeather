//
//  qWeatherApp.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Routing
import SwiftUI

// MARK: - qWeatherApp

@main
struct qWeatherApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject var userSettings = UserSettings()

    var body: some Scene {
        return WindowGroup {
            RoutingView(Route.self) { router in
                ProgressView()
                    .scaleEffect(.init(width: 2, height: 2))
                    .onAppear {
                        if userSettings.isLoaded {
                            if userSettings.isOnboarded {
                                router.replace(.home)
                            } else {
                                router.replace(.onboarding)
                            }
                        } else {
                            router.replace(.landing)
                        }
                    }
                    .tint(Color.gradient)
            }
            .environmentObject(userSettings)
        }
    }
}

// MARK: - AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return true
    }
}
