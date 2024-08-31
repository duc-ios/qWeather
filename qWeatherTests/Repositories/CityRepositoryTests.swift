//
//  CityRepositoryTests.swift
//  qWeatherTests
//
//  Created by Duc on 1/9/24.
//

import Foundation
@testable import qWeather
import XCTest

final class CityRepositoryTests: XCTestCase {
    private var sut: CityRepository!
    
    override func setUp() {
        super.setUp()
        
        sut = CityRepositoryImp()
        cleanUp()
    }
    
    override func tearDown() {
        cleanUp()
        sut = nil
        
        super.tearDown()
    }
    
    func cleanUp() {
        do {
            if let city = try sut.read(primaryKey: 0) {
                try sut.delete(city)
            }
        } catch {
            print(error)
        }
    }
    
    func testCreate() {
        do {
            // given
            let city = CityModel(id: 0, name: "Dummy City", country: "VN", lat: 10.75, lon: 106.666672)
            
            // when
            try sut.create(city)
            let createdCity = try sut.read(primaryKey: 0)
            
            // then
            XCTAssertNotNil(createdCity)
        } catch {
            XCTAssertTrue(false, error.localizedDescription)
        }
    }
    
    func testRead() {
        do {
            // given
            let city = CityModel(id: 0, name: "Dummy City", country: "VN", lat: 10.75, lon: 106.666672)
            try sut.create(city)
            let query = String(format: "name CONTAINS[c] '%@'", "Dummy City")
            
            // when
            let cities = try sut.read(query, sorts: [("country", true), ("name", true)])
            
            // then
            XCTAssertTrue(cities.contains { $0.name == "Dummy City" })
        } catch {
            XCTAssertTrue(false, error.localizedDescription)
        }
    }
    
    func testUpdate() {
        do {
            // given
            let city = CityModel(id: 0, name: "Dummy City", country: "VN", lat: 10.75, lon: 106.666672)
            let isSaved = city.isSaved ?? false
            try sut.create(city)

            // when
            try sut.update {
                city.isSaved = !isSaved
            }
            let updatedCity = try sut.read(primaryKey: 0)
            
            // then
            XCTAssertEqual(updatedCity?.isSaved, !isSaved)
        } catch {
            XCTAssertTrue(false, error.localizedDescription)
        }
    }
    
    func testDelete() {
        do {
            // given
            let city = CityModel(id: 0, name: "Dummy City", country: "VN", lat: 10.75, lon: 106.666672)
            let idToDelete = city.id
            try sut.create(city)

            // when
            if let cityToDelete = try sut.read(primaryKey: idToDelete) {
                try sut.delete(cityToDelete)
            }
            
            // then
            XCTAssertNil(try sut.read(primaryKey: idToDelete))
        } catch {
            XCTAssertTrue(false, error.localizedDescription)
        }
    }
}
