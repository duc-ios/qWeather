//
//  CityRepository.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation
import RealmSwift

// MARK: - CityRepository

protocol CityRepository {
    /**
     Adds one or more `CityModel` items to the database.
     
     - Parameter items: A variadic list of `CityModel` items to be added to the database.
     
     - Throws: An error if the items cannot be created, such as a database write failure.
     
     - Example:
     ```swift
     try create(CityModel(name: "New York"), CityModel(name: "Los Angeles"))
     ```
     */
    func create(_ items: CityModel...) throws
    
    /**
     Adds an array of `CityModel` items to the database.
     
     - Parameter items: An array of `CityModel` items to be added to the database.
     
     - Throws: An error if the items cannot be created, such as a database write failure.
     
     - Example:
     ```swift
     let cities = [CityModel(name: "New York"), CityModel(name: "Los Angeles")]
     try create(cities)
     ```
     */
    func create(_ items: [CityModel]) throws
    
    /**
     Retrieves a `CityModel` item from the database using its primary key.
     
     - Parameter primaryKey: The primary key value used to identify the `CityModel` item.
     
     - Returns: The `CityModel` item if found, or `nil` if not found.
     
     - Throws: An error if the item cannot be retrieved, such as a database read failure.
     
     - Example:
     ```swift
     if let city = try read(primaryKey: 1) {
        print("City name: \(city.name)")
     }
     ```
     */
    func read(primaryKey: Any) throws -> CityModel?
    
    /**
     Retrieves an array of `CityModel` items from the database that match the specified predicate and sort order.
     
     - Parameters:
     - predicate: An optional string used to filter the results. If `nil`, all items are returned.
     - sorts: An array of tuples specifying the key paths and sort directions for ordering the results.
     
     - Returns: An array of `CityModel` items that match the specified criteria.
     
     - Throws: An error if the items cannot be retrieved, such as a database read failure.
     
     - Example:
     ```swift
     let cities = try read("name BEGINSWITH 'A'", sorts: [(keyPath: "name", asc: true)])
     ```
     */
    func read(_ predicate: String?, sorts: [(keyPath: String, asc: Bool)]) throws -> [CityModel]
    
    /**
     Performs an update operation on the database within a transaction.
     
     - Parameter handler: A closure that contains the update logic. This closure is executed within a transaction.
     
     - Throws: An error if the update fails, such as a database write failure.
     
     - Example:
     ```swift
     try update {
        city.name = "San Francisco"
     }
     ```
     */
    func update(_ handler: VoidCallback) throws
    
    /**
     Deletes one or more `CityModel` items from the database.
     
     - Parameter items: A variadic list of `CityModel` items to be deleted from the database.
     
     - Throws: An error if the items cannot be deleted, such as a database write failure.
     
     - Example:
     ```swift
     try delete(CityModel(name: "New York"), CityModel(name: "Los Angeles"))
     ```
     */
    func delete(_ items: CityModel...) throws
    
    /**
     Deletes an array of `CityModel` items from the database.
     
     - Parameter items: An array of `CityModel` items to be deleted from the database.
     
     - Throws: An error if the items cannot be deleted, such as a database write failure.
     
     - Example:
     ```swift
     let citiesToDelete = [CityModel(name: "New York"), CityModel(name: "Los Angeles")]
     try delete(citiesToDelete)
     ```
     */
    func delete(_ items: [CityModel]) throws
    
    /**
     Observes changes to `CityModel` items in the database that match the specified predicate and sort order.
     
     - Parameters:
     - predicate: An optional string used to filter the results. If `nil`, all items are observed.
     - sorts: An array of tuples specifying the key paths and sort directions for ordering the results.
     - handler: A closure that is called whenever the observed data changes. It passes a `Result` containing an array of `CityModel` items on success or an `AppError` on failure.
     
     - Throws: An error if the observation fails to start, such as a database connection issue.
     
     - Example:
     ```swift
     try observe("name BEGINSWITH 'A'", sorts: [(keyPath: "name", asc: true)]) { result in
        switch result {
        case .success(let cities):
            print("Observed cities: \(cities)")
        case .failure(let error):
            print("Failed to observe: \(error)")
        }
     }
     ```
     */
    func observe(_ predicate: String?, sorts: [(keyPath: String, asc: Bool)], handler: @escaping ValueCallback<Result<[CityModel], AppError>>) throws
}

// MARK: - CityRepositoryImp

final class CityRepositoryImp: CityRepository {
    private let db: RealmDB

    var tokens = Set<NotificationToken>()

    deinit {
        tokens.forEach { $0.invalidate() }
    }

    init(db: RealmDB = RealmDB()) {
        self.db = db
    }

    func create(_ items: CityModel...) throws {
        try db.create(items)
    }

    func create(_ items: [CityModel]) throws {
        try db.create(items)
    }

    func read(primaryKey: Any) throws -> CityModel? {
        try db.read(primaryKey: primaryKey)
    }

    func read(_ predicate: String? = nil, sorts: [(keyPath: String, asc: Bool)]) throws -> [CityModel] {
        try db.read(predicate, sorts: sorts.map { RealmSwift.SortDescriptor(keyPath: $0.keyPath, ascending: $0.asc) })
    }

    func update(_ handler: VoidCallback) throws {
        try db.update(handler)
    }

    func delete(_ items: CityModel...) throws {
        try db.delete(items)
    }

    func delete(_ items: [CityModel]) throws {
        try db.delete(items)
    }

    func observe(_ predicate: String?, sorts: [(keyPath: String, asc: Bool)], handler: @escaping ValueCallback<Result<[CityModel], AppError>>) throws {
        try tokens.insert(db.observe(predicate, sorts: sorts.map { RealmSwift.SortDescriptor(keyPath: $0.keyPath, ascending: $0.asc) }, handler: handler))
    }
}
