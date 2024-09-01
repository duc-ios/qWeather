//
//  HomeInteractorTests.swift
//  qWeatherTests
//
//  Created by Duc on 1/9/24.
//

import Foundation
@testable import qWeather
import SwiftData
import XCTest

// MARK: - HomeInteractorTests

final class HomeInteractorTests: XCTestCase {
    private var sut: HomeBusinessLogic!
    private var presenter: HomePresenterMock!
    private var repository: CityRepository!
    
    @MainActor override func setUp() {
        super.setUp()
        
        UIView.setAnimationsEnabled(false)
        
        presenter = HomePresenterMock()
        repository = CityRepositoryMock()
        
        sut = HomeInteractor(
            presenter: presenter,
            repository: repository
        )
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        repository = nil
        
        UIView.setAnimationsEnabled(true)

        super.tearDown()
    }
    
    func testGetGreeting() {
        // Given
        let dateComponents = DateComponents(hour: 12)
        let date = Calendar.current.date(from: dateComponents)
        let request = Home.GetGreeting.Request(date: date!)
        
        // When
        sut.getGreeting(request: request)
        
        // Then
        XCTAssertEqual(presenter.greeting, "Good Afternoon!")
    }
    
    func testSearchCities() {
        // Given
        let request = Home.SearchCities.Request(keyword: "Ho Chi Minh")
        
        // When
        sut.searchCities(request: request)
        
        // Then
        XCTAssertTrue(presenter.presentCitiesCalled)
    }
}

// MARK: - HomePresenterMock

final class HomePresenterMock: HomePresentationLogic {
    var isLoading = false
    var presentAlertCalled = false
    var presentErrorCalled = false
    var greeting = ""
    var presentSavedCitiesCalled = false
    var presentCitiesCalled = false
    
    func presentIsLoading(isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    func presentAlert(response: Home.ShowAlert.Response) {
        presentAlertCalled = true
    }
    
    func presentError(response: Home.ShowError.Response) {
        presentErrorCalled = true
    }
    
    func presentGreeting(response: Home.GetGreeting.Response) {
        greeting = response.greeting
    }
    
    func presentSavedCities(response: Home.GetSavedCities.Response) {
        presentSavedCitiesCalled = true
    }
    
    func presentCities(response: Home.SearchCities.Response) {
        presentCitiesCalled = true
    }
}

// MARK: - CityRepositoryMock

final class CityRepositoryMock: CityRepository {
    func create(_ items: qWeather.CityModel...) throws {
        //
    }
    
    func create(_ items: [qWeather.CityModel]) throws {
        //
    }
    
    func read(primaryKey: Any) throws -> qWeather.CityModel? {
        nil
    }
    
    func read(_ predicate: String?, sorts: [(keyPath: String, asc: Bool)]) throws -> [qWeather.CityModel] {
        []
    }
    
    func update(_ handler: () -> Void) throws {
        //
    }
    
    func delete(_ items: qWeather.CityModel...) throws {
        //
    }
    
    func delete(_ items: [qWeather.CityModel]) throws {
        //
    }
    
    func observe(_ predicate: String?, sorts: [(keyPath: String, asc: Bool)], handler: @escaping qWeather.ValueCallback<Result<[qWeather.CityModel], qWeather.AppError>>) throws {
        //
    }
}
