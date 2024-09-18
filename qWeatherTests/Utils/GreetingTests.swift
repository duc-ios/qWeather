//
//  GreetingTests.swift
//  qWeatherTests
//
//  Created by Duc on 29/8/24.
//

import Foundation
@testable import qWeather
import Testing

final class GreetingTests {
    var greeting: Greeting!

    init() {
        greeting = Greeting()
    }

    deinit {
        greeting = nil
    }

    @Test func morning() throws {
        // given
        let date = Calendar.current.date(from: DateComponents(hour: 0))!

        // when
        let result = greeting.text(date: date)

        // then
        #expect(result == "Good Morning!")
    }

    @Test func afternoon() throws {
        // given
        let date = Calendar.current.date(from: DateComponents(hour: 12))!

        // when
        let result = greeting.text(date: date)

        // then
        #expect(result == "Good Afternoon!")
    }

    @Test func night() throws {
        // given
        let date = Calendar.current.date(from: DateComponents(hour: 17))!

        // when
        let result = greeting.text(date: date)

        // then
        #expect(result == "Good Evening!")
    }
}
