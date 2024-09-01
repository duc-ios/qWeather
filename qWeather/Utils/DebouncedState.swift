//
//  DebouncedState.swift
//  qWeather
//
//  Created by Duc on 2/9/24.
//

import Foundation

// MARK: - DebounceText

class DebounceState<Value>: ObservableObject {
    @Published var currentValue: Value
    @Published var debouncedValue: Value

    init(initialValue: Value, delay: Double = 0.5)
    {
        _currentValue = .init(initialValue: initialValue)
        _debouncedValue = .init(initialValue: initialValue)

        $currentValue
            .debounce(for: .seconds(delay), scheduler: RunLoop.main)
            .assign(to: &$debouncedValue)
    }
}
