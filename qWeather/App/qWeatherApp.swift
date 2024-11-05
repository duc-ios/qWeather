//
//  qWeatherApp.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import NavigationStackBackport
import SwiftUI

// MARK: - qWeatherApp

@main
struct qWeatherApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var userSettings = UserSettings()
    @StateObject private var router = Router()

    var body: some Scene {
        return WindowGroup {
            NavigationStackBackport.NavigationStack(path: $router.path) {
                if #available(iOS 16.0, *) {
                    progress.tint(Color.gradient)
                } else {
                    progress
                }
            }
            .environmentObject(userSettings)
        }
    }
    
    var progress: some View {
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
            .backport.navigationDestination(for: Route.self) {
                $0.destination().environmentObject(router)
            }
    }
}

// MARK: - AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return true
    }
}
