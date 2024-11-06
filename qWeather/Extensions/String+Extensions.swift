//
//  String+Extensions.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation

extension String {
    var trimmed: String { trimmingCharacters(in: .whitespacesAndNewlines) }
    var isBlank: Bool { trimmed.isEmpty }
}

extension String? {
    var isNilOrBlank: Bool { (self ?? "").isBlank }
}
