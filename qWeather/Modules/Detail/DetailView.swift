//
//  DetailView.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import SwiftUI

// MARK: - DetailEvent

enum DetailEvent: Equatable {
    enum View: Equatable {
        case loading(Bool),
             alert(title: String, message: String),
             error(AppError),
             currentWeather(WeatherModel)
    }

    case view(View)
}

// MARK: - DetailDisplayLogic

protocol DetailDisplayLogic {
    var event: DetailEvent? { get set }
}

// MARK: - DetailView

struct DetailView: View {
    let interactor: DetailBusinessLogic
    @StateObject var store: DetailDataStore
    @EnvironmentObject var router: Router

    var body: some View {
        VStack {
            if store.isLoading {
                ProgressView().tint(.white).scaleEffect(.init(width: 2, height: 2))
            } else {
                CachedAsyncImage(url: store.icon, content: {
                    $0.resizable().aspectRatio(contentMode: .fit)
                }, placeholder: {
                    ProgressView().tint(.white)
                })
                .frame(width: 150, height: 150)
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
        .modifier(BackgroundGradientModifier())
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
                    router.path.removeLast()
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
    NavigationView {
        DetailView
            .configured(city: .init(
                name: "Ho Chi Minh",
                lat: 10.75,
                lon: 106.6667
            ))
            .environmentObject(Router())
    }
}
#endif
