//
//  OnboardingView.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import SwiftUI

struct OnboardingContentView: View {
    let title: String
    let image: String
    let description: String

    var body: some View {
        VStack {
            Image(systemName: image)
                .font(.largeTitle)
                .padding()
                .foregroundStyle(Color.gradientPink)
            Text(title)
                .font(.headline)
            Text(description)
                .multilineTextAlignment(.center)
                .padding()
                .foregroundStyle(.gray)
        }
        .frame(height: 300)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .padding()
    }
}

struct OnboardingView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var userSettings: UserSettings
    @State private var selectedIndex = 0

    var body: some View {
        return VStack {
            Text("qWeather")
                .font(.largeTitle.weight(.semibold))
                .foregroundStyle(.white)
            TabView(selection: $selectedIndex) {
                OnboardingContentView(
                    title: L10n.Onboarding.Title._1,
                    image: "globe",
                    description: L10n.Onboarding.Desc._1)
                    .tag(0)
                OnboardingContentView(
                    title: L10n.Onboarding.Title._2,
                    image: "square.and.arrow.down",
                    description: L10n.Onboarding.Desc._2)
                    .tag(1)
                OnboardingContentView(
                    title: L10n.Onboarding.Title._3,
                    image: "sun.rain",
                    description: L10n.Onboarding.Desc._3)
                    .tag(2)
            }
            .frame(height: 330)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeOut, value: selectedIndex)

            PageControl(totalIndex: 3, selectedIndex: $selectedIndex).padding()

            Button(action: {
                userSettings.isOnboarded = true
                router.pop(to: .home)
            }, label: {
                Text(L10n.getStarted)
            })
            .padding()
            .font(.title3.weight(.semibold))
            .foregroundStyle(Color.gradient)
            .background(.white)
            .clipShape(Capsule())
            .padding()
        }
        .frame(maxHeight: .infinity)
        .background(Color.gradient)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    OnboardingView()
        .environmentObject(Router())
        .environmentObject(UserSettings())
}
