//
//  Greeting.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation

struct Greeting {
    func text(date: Date) -> String {
        let hour = Calendar.current.component(.hour, from: date)
        switch hour {
        case 0..<12:
            return "Good Morning!"
        case 12..<17:
            return "Good Afternoon!"
        default:
            return "Good Evening!"
        }
    }
}
