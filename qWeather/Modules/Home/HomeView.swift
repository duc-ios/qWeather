//
//  HomeView.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import SwiftUI

// MARK: - HomeDisplayLogic

protocol HomeDisplayLogic {
    var store: HomeDataStore { get set }
}

// MARK: - HomeView

struct HomeView: View, HomeDisplayLogic {
    var interactor: HomeBusinessLogic!

    @ObservedObject var store = HomeDataStore()
    @EnvironmentObject var router: Router

    var body: some View {
        Group {
            if store.isSearching {
                if store.cities.isEmpty {
                    Text(L10n.noData)
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
                    Text(L10n.noData)
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
            text: $store.keyword,
            isPresented: $store.isSearching,
            placement: .automatic)
        .navigationTitle(store.greeting)
        .navigationBarBackButtonHidden()
        .alert(store.alertTitle,
               isPresented: $store.displayAlert,
               actions: { Button(L10n.ok) {} },
               message: { Text(store.alertMessage) })
        .onAppear {
            interactor.getGreeting(request: .init())
        }
        .onChange(of: store.state, perform: handleState)
    }

    @MainActor
    func handleState(_ state: HomeDataStore.State?) {
        switch state {
        case .loading(let isLoading):
            store.isLoading = isLoading
        case .alert(let title, let message):
            store.alertTitle = title
            store.alertMessage = message
            store.displayAlert = true
        case .error(let error):
            store.state = .alert(title: error.title, message: error.message)
        case .greeting(let greeting):
            store.greeting = greeting
        case .search(let keyword):
            interactor.searchCities(request: .init(keyword: keyword))
        case .cities(let savedCities, let cities):
            withAnimation {
                store.savedCities = savedCities
                store.cities = cities
            }
        default:
            break
        }
    }
}

#if DEBUG
#Preview {
    HomeView().configured()
}
#endif
