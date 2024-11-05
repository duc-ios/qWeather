//
//  BackgroundGradientModifier.swift
//  qWeather
//
//  Created by Duc on 6/11/24.
//

import SwiftUI

struct BackgroundGradientModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            return content.background(Color.gradient)
        } else {
            return content.background(Color.gradientPink)
        }
    }
}
