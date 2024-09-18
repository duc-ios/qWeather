//
//  HomePresenterTests.swift
//  qWeatherTests
//
//  Created by Duc on 1/9/24.
//

import Combine
import Foundation
@testable import qWeather
import Testing
import UIKit

// MARK: - HomePresenterTests

final class HomePresenterTests {
    private var sut: HomePresenter!
    private var view: HomeViewMock!

    init() {
        UIView.setAnimationsEnabled(false)

        view = HomeViewMock()
        sut = HomePresenter(view: view)
    }

    deinit {
        sut = nil
        view = nil

        UIView.setAnimationsEnabled(true)
    }

    @Test func getGreetings() {
        // Given
        let response = Home.GetGreeting.Response(greeting: "Good Morning!")

        // When
        sut.presentGreeting(response: response)

        // Then
        Task { @MainActor [weak self] in
            guard let self else { return }
            #expect(view.greeting == "Good Morning!")
        }
    }

    @Test func displayError() async throws {
        // Given
        let error = AppError.unexpected

        // When
        sut.presentError(response: .init(error: error))
        try await Task.sleep(nanoseconds: 100_000_000)

        // Then
        #expect(view.alertTitle == error.title)
        #expect(view.alertMessage == error.message)
        #expect(view.displayAlert == true)
    }
}

// MARK: - HomeViewMock

final class HomeViewMock: HomeDisplayLogic {
    var greeting: String?
    var alertTitle: String?
    var alertMessage: String?
    var displayAlert = false

    var event: HomeEvent? {
        didSet {
            guard case let .view(event) = event else { return }
            switch event {
            case let .greeting(greeting):
                self.greeting = greeting
            case let .alert(title, message):
                alertTitle = title
                alertMessage = message
                displayAlert = true
            case let .error(error):
                alertTitle = error.title
                alertMessage = error.message
                displayAlert = true
            default:
                break
            }
        }
    }
}
