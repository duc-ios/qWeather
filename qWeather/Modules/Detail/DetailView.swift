//
//  DetailView.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

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
            Text("Detail")
        }
        .navigationTitle("Detail")
        .alert(store.alertTitle,
               isPresented: $store.displayAlert,
               actions: { Button(L10n.ok) {} },
               message: { Text(store.alertMessage) })
        .onChange(of: store.state, perform: handleState)
    }

    func handleState(_ state: DetailDataStore.State?) {
        switch state {
        case .loading(let isLoading):
            store.isLoading = isLoading
        case .error(let error):
            store.alertTitle = error.title
            store.alertMessage = error.message
            store.displayAlert = true
        default:
            break
        }
    }
}

#if DEBUG
#Preview {
    DetailView().configured(city: .init(name: "City"))
}
#endif
