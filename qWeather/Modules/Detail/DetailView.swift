//
//  DetailView.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Kingfisher
import SwiftUI

// MARK: - DetailDisplayLogic

protocol DetailDisplayLogic {
    var store: DetailDataStore { get set }
}

// MARK: - DetailView

struct DetailView: View, DetailDisplayLogic {
    var interactor: DetailBusinessLogic!
    @ObservedObject var store = DetailDataStore()
    @EnvironmentObject var router: Router

    var body: some View {
        VStack {
            if store.isLoading {
                ProgressView().tint(.white).scaleEffect(.init(width: 2, height: 2))
            } else {
                KFImage(store.icon)
                    .placeholder { _ in ProgressView().tint(.white) }
                    .frame(width: 100, height: 100)
                VStack {
                    Text(Date.now, format: .dateTime).font(.callout)
                    Text(store.name).font(.title)
                    Text(store.temp).font(.largeTitle.weight(.bold))
                }
                .foregroundColor(.gradientPurple)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                Text(L10n.Detail.feelsLike(store.feelsLike))
                    .font(.body.weight(.medium))
                Text(store.descriptions)
                Text(store.lh)
                VStack {
                    HStack {
                        Text(store.sunrise)
                        Spacer()
                        Text(store.sunset)
                    }
                    HStack {
                        Text(store.wind)
                        Spacer()
                        Text(store.pressure)
                    }
                    HStack {
                        Text(store.humidity)
                        Spacer()
                        Text(store.visibility)
                    }
                }
                .padding()
                .foregroundColor(.gradientPurple)
                .background(.white.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .font(.footnote)
            }
        }
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gradient)
        .alert(store.alertTitle,
               isPresented: $store.displayAlert,
               actions: { Button(L10n.ok) {} },
               message: { Text(store.alertMessage) })
        .onAppear {
            interactor.getCurrentWeather(request: .init(city: store.city))
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    router.pop(to: .home)
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(.white)
                })
            }
            ToolbarItem(placement: .principal) {
                Text(store.name)
                    .foregroundColor(.white)
            }
        }
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        DetailView()
            .configured(city: .init(
                name: "Ho Chi Minh",
                lat: 10.75,
                lon: 106.6667
            ))
            .environmentObject(Router())
    }
}
#endif
