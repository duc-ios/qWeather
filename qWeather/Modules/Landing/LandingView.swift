//
//  LandingView.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import SwiftUI

// MARK: - LandingDisplayLogic

protocol LandingDisplayLogic {
    var store: LandingDataStore { get set }
}

// MARK: - LandingView

struct LandingView: View, LandingDisplayLogic {
    var interactor: LandingBusinessLogic!
    @ObservedObject var store = LandingDataStore()
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
                        router.pop(to: .home)
                    } else {
                        router.pop(to: .onboarding)
                    }
            }
        }
    }
}

#if DEBUG
#Preview {
    LandingView()
        .configured()
        .environmentObject(Router())
        .environmentObject(UserSettings())
}
#endif
