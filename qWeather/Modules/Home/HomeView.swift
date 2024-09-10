//
//  HomeView.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import SwiftUI

// MARK: - HomeEvent

enum HomeEvent: Equatable {
    enum View: Equatable {
        case loading(Bool),
             alert(title: String, message: String),
             error(AppError),
             greeting(String),
             savedCities([CityModel]),
             cities([CityModel])
    }

    case view(View)
}

// MARK: - HomeDisplayLogic

protocol HomeDisplayLogic {
    var event: HomeEvent? { get set }
}

// MARK: - HomeView

struct HomeView: View {
    var interactor: HomeBusinessLogic!

    @ObservedObject var store = HomeDataStore()
    @EnvironmentObject var router: Router
    @StateObject var keyword = DebounceState(initialValue: "")

    var body: some View {
        Group {
            if store.isSearching {
                if store.cities.isEmpty {
                    Text(L10n.noDataEnterToSearchCity).multilineTextAlignment(.center)
                } else {
                    List {
                        ForEach(store.cities) { city in
                            CityCard(city: city,
                                     action: {
                                         router.show(.detail(city))
                                     },
                                     saveAction: {
                                         interactor.updateCity(request: .init(
                                             cityId: city.id,
                                             isSaved: !(city.isSaved ?? false))
                                         )
                                     })
                        }
                    }
                }
            } else {
                if store.savedCities.isEmpty {
                    Text(L10n.noDataEnterToSearchCity).multilineTextAlignment(.center)
                } else {
                    List {
                        ForEach(store.savedCities) { city in
                            CityCard(city: city,
                                     action: {
                                         router.show(.detail(city))
                                     },
                                     saveAction: {
                                         interactor.updateCity(request: .init(
                                             cityId: city.id,
                                             isSaved: !(city.isSaved ?? false))
                                         )
                                     })
                        }
                    }
                }
            }
        }
        .searchable_iOS16(
            text: $keyword.currentValue,
            isPresented: $store.isSearching,
            placement: .automatic)
        .navigationTitle(store.greeting)
        .navigationBarBackButtonHidden()
        .alert(store.alertTitle,
               isPresented: $store.displayAlert,
               actions: { Button(L10n.ok) {} },
               message: { Text(store.alertMessage) })
        .onAppear {
            interactor.getGreeting(request: .init(date: Date()))
        }
        .onChange(of: keyword.debouncedValue) {
            interactor.searchCities(request: .init(keyword: $0))
        }
    }
}

#if DEBUG
#Preview {
    HomeView().configured()
}
#endif
