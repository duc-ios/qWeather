//
//  CityCard.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import SwiftUI

struct CityCard: View {
    let city: CityModel
    let action: VoidCallback
    let saveAction: VoidCallback

    var body: some View {
        Button(action: action) {
            HStack {
                Text("\(city.name), \(city.country)")
                Spacer()
                Button(action: saveAction) {
                    if city.isSaved == true {
                        Image(systemName: "star.fill").foregroundStyle(.yellow)
                    } else {
                        Image(systemName: "star")
                    }
                }
            }
        }
    }
}

#Preview {
    List {
        CityCard(city: .init(name: "City"), action: {}, saveAction: {})
        CityCard(city: .init(name: "City", isSaved: true), action: {}, saveAction: {})
    }
}
