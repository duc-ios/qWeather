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
            Image("launch-screen-ic")
            Text("Loading cities, please wait ...")
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
        .onChange(of: store.state, perform: handleState)
    }

    func handleState(_ state: LandingDataStore.State?) {
        switch state {
        case .loading(let isLoading):
            store.isLoading = isLoading
        case .error(let error):
            store.alertTitle = error.title
            store.alertMessage = error.message
            store.displayAlert = true
        case .homeOrOnboarding:
            userSettings.isLoaded = true
            if userSettings.isOnboarded {
                router.pop(to: .home)
            } else {
                router.pop(to: .onboarding)
            }
        default:
            break
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
