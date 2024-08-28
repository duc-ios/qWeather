//
//  LinearButtonStyle.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import SwiftUI

struct LinearButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding()
            .font(.caption.weight(.semibold))
            .foregroundStyle(Color.white)
            .background(Capsule().foregroundStyle(Color.gradient).opacity(isEnabled ? 1 : 0.5))
    }
}

#Preview {
    Button(action: {}, label: { Text("Linear Button") })
        .buttonStyle(LinearButtonStyle())
}
