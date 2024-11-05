//
//  LandingView.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import SwiftUI

// MARK: - LandingEvent

enum LandingEvent: Equatable {
    enum View: Equatable {
        case loading(Bool),
             alert(title: String, message: String),
             error(AppError)
    }

    enum Router: Equatable {
        case homeOrOnboarding
    }

    case view(View), router(Router)
}

// MARK: - LandingDisplayLogic

protocol LandingDisplayLogic {
    var event: LandingEvent? { get set }
}

// MARK: - LandingView

struct LandingView: View {
    let interactor: LandingBusinessLogic
    @StateObject var store: LandingDataStore
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var router: Router

    var body: some View {
        VStack {
            Asset.launchScreenIc.swiftUIImage
            Text(L10n.Landing.loading)
            ProgressView()
        }
        .offset(y: 1.5)
        .onAppear {
            interactor.getCities(request: .init())
        }
        .navigationBarBackButtonHidden()
        .alert(store.alertTitle,
               isPresented: $store.displayAlert,
               actions: { Button(L10n.ok) {} },
               message: { Text(store.alertMessage) })
        .onChange(of: store.event) {
            guard case .router(let event) = $0 else { return }
            switch event {
                case .homeOrOnboarding:
                    userSettings.isLoaded = true
                    if userSettings.isOnboarded == true {
                        router.replace(.home)
                    } else {
                        router.replace(.onboarding)
                    }
            }
        }
    }
}

#if DEBUG
#Preview {
    NavigationView {
        LandingView
            .configured()
            .environmentObject(UserSettings())
            .environmentObject(Router())
    }
}
#endif
