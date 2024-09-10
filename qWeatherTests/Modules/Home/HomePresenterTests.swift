//
//  HomePresenterTests.swift
//  qWeatherTests
//
//  Created by Duc on 1/9/24.
//

import Combine
import Foundation
@testable import qWeather
import XCTest

// MARK: - HomePresenterTests

final class HomePresenterTests: XCTestCase {
    private var sut: HomePresenter!
    private var view: HomeViewMock!
    
    override func setUp() {
        super.setUp()
        
        UIView.setAnimationsEnabled(false)
        
        view = HomeViewMock()
        sut = HomePresenter(view: view)
    }
    
    override func tearDown() {
        sut = nil

        UIView.setAnimationsEnabled(true)

        super.tearDown()
    }
    
    func testGetGreetings() {
        // Given
        let response = Home.GetGreeting.Response(greeting: "Good Morning!")
        
        // When
        sut.presentGreeting(response: response)
        
        // Then
        XCTAssertEqual(view.greeting, "Good Morning!")
    }
    
    func testDisplayError() {
        // Given
        let error = AppError.unexpected
        
        // When
        sut.presentError(response: .init(error: error))
        
        // Then
        XCTAssertEqual(view.alertTitle, error.title)
        XCTAssertEqual(view.alertMessage, error.message)
        XCTAssertEqual(view.displayAlert, true)
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
            case .greeting(let greeting):
                self.greeting = greeting
            case .alert(let title, let message):
                alertTitle = title
                alertMessage = message
                displayAlert = true
            case .error(let error):
                alertTitle = error.title
                alertMessage = error.message
                displayAlert = true
            default:
                break
            }
        }
    }
}
