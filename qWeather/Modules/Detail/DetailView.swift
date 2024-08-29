//
//  DetailView.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import SwiftUI
import Kingfisher

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
            if let weather = store.weather {
                KFImage(weather.weather.first?.icon)
                    .placeholder { _ in ProgressView().tint(.white) }
                    .frame(width: 100, height: 100)
                VStack {
                    Text(Date.now, format: .dateTime).font(.callout)
                    Text(weather.name).font(.title)
                    Text(weather.main.temp).font(.largeTitle.weight(.bold))
                }
                .foregroundColor(.gradientPurple)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                Text("Feels like \(weather.main.feelsLike)")
                    .font(.body.weight(.medium))
                Text(weather.weather.map { $0.description }.joined(separator: ". "))
                Text("H:\(weather.main.tempMin) - L:\(weather.main.tempMax)")
                VStack {
                    HStack {
                        Text("Sunrise: \(weather.sys.sunrise.formatted(date: .omitted, time: .shortened))")
                        Spacer()
                        Text("Sunset: \(weather.sys.sunset.formatted(date: .omitted, time: .shortened))")
                    }
                    HStack {
                        Text("\(weather.wind.speed) \(weather.wind.deg)")
                        Spacer()
                        Text(weather.main.pressure)
                    }
                    HStack {
                        Text("Humidity: \(weather.main.humidity)")
                        Spacer()
                        Text("Visibility: \(weather.visibility)")
                    }
                }
                .padding()
                .foregroundColor(.gradientPurple)
                .background(.white.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .font(.footnote)
            } else {
                ProgressView().tint(.white).scaleEffect(.init(width: 2, height: 2))
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
        .onChange(of: store.state, perform: handleState)
        .onAppear {
            interactor.getCurrentWeather(request: .init(city: store.city))
        }
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
                Text(store.weather?.name ?? store.city.name)
                    .foregroundColor(.white)
            }
        }
    }

    func handleState(_ state: DetailDataStore.State?) {
        switch state {
        case .loading(let isLoading):
            store.isLoading = isLoading
        case .error(let error):
            store.alertTitle = error.title
            store.alertMessage = error.message
            store.displayAlert = true
        case .currentWeather(let weather):
            store.weather = weather
        default:
            break
        }
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        DetailView()
            .configured(city: .init(
                name: "Ho Chi Minh",
                coord: CoordModel(lon: 106.6667, lat: 10.75))
            )
            .environmentObject(Router())
    }
}
#endif
