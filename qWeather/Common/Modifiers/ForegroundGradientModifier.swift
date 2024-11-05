//
//  ForegroundGradientModifier.swift
//  qWeather
//
//  Created by Duc on 6/11/24.
//

import SwiftUI

struct ForegroundGradientModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            return content.foregroundStyle(Color.gradient)
        } else {
            return content.foregroundStyle(Color.gradientPink)
        }
    }
}
