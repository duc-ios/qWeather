//
//  CityRepositoryTests.swift
//  qWeatherTests
//
//  Created by Duc on 1/9/24.
//

import Foundation
@testable import qWeather
import Testing

final class CityRepositoryTests {
    private var sut: CityRepository!

    init() {
        sut = CityRepositoryImp()
        cleanUp()
    }

    deinit {
        sut = nil
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

    @Test func dbCreate() throws {
        // given
        let city = CityModel(id: 0, name: "Dummy City", country: "VN", lat: 10.75, lon: 106.666672)

        // when
        try sut.create(city)
        let createdCity = try sut.read(primaryKey: 0)

        // then
        #expect(createdCity != nil)
    }

    @Test func dbRead() throws {
        // given
        let city = CityModel(id: 0, name: "Dummy City", country: "VN", lat: 10.75, lon: 106.666672)
        try sut.create(city)
        let query = String(format: "name CONTAINS[c] '%@'", "Dummy City")

        // when
        let cities = try sut.read(query, sorts: [("country", true), ("name", true)])

        // then
        #expect(cities.contains { $0.name == "Dummy City" } == true)
    }

    @Test func dbUpdate() throws {
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
        #expect(updatedCity?.isSaved == !isSaved)
    }

    @Test func dbDelete() throws {
        // given
        let city = CityModel(id: 0, name: "Dummy City", country: "VN", lat: 10.75, lon: 106.666672)
        let idToDelete = city.id
        try sut.create(city)

        // when
        if let cityToDelete = try sut.read(primaryKey: idToDelete) {
            try sut.delete(cityToDelete)
        }

        // then
        #expect(try sut.read(primaryKey: idToDelete) == nil)
    }
}
