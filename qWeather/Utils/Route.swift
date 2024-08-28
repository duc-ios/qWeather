//
//  Route.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

enum Route: Hashable {
    case landing,
         onboarding,
         home,
         detail(CityModel)
}
