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
        XCTAssertEqual(view.store.greeting, "Good Morning!")
    }
    
    func testDisplayError() {
        // Given
        let error = AppError.unexpected
        
        // When
        sut.presentError(response: .init(error: error))
        
        // Then
        XCTAssertEqual(view.store.alertTitle, error.title)
        XCTAssertEqual(view.store.alertMessage, error.message)
        XCTAssertEqual(view.store.displayAlert, true)
    }
}

// MARK: - HomeViewMock

final class HomeViewMock: HomeDisplayLogic {
    var store = HomeDataStore()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        store.$event.sink { [weak self] in
            guard let self else { return }
            switch $0 {
            case .greeting(let greeting):
                store.greeting = greeting
            case .error(let error):
                store.alertTitle = error.title
                store.alertMessage = error.message
                store.displayAlert = true
            default:
                break
            }
        }.store(in: &cancellables)
    }
}
