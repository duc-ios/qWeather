//
//  RealmDB.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation
import RealmSwift

// MARK: - RealmDB

struct RealmDB {
    private let configuration: Realm.Configuration

    /**
     Initializes the Realm database with a specified configuration.
     - Parameter configuration: The configuration used for initializing the Realm instance. Defaults to a configuration that automatically deletes the Realm file if migration is needed.
     */
    init(configuration: Realm.Configuration = .init(deleteRealmIfMigrationNeeded: true)) {
        self.configuration = .init(deleteRealmIfMigrationNeeded: true)
    }

    /**
     Creates and stores multiple instances of a model in the database.
     - Parameter items: The instances of the model to be created and saved. Accepts one or more models of the specified type.
     - Throws: An error if the creation fails.
     */
    func create<Model: Object>(_ items: Model...) throws {
        try create(items)
    }

    /**
     Creates and stores multiple instances of a model in the database.
     - Parameter items: The instances of the model to be created and saved. Accepts one or more models of the specified type.
     - Throws: An error if the creation fails.
     */
    func create<Model: Object>(_ items: [Model]) throws {
        let realm = try Realm(configuration: configuration)
        try realm.write {
            for item in items {
                realm.add(item)
            }
        }
    }

    /**
     Reads and returns a list of models from the database based on an optional predicate and sorting.
     - Parameters:
       - predicate: A string filter used to specify conditions for reading data. If `nil`, all objects of the model type are returned.
       - sorts: An array of sort descriptors used to sort the results. Defaults to an empty array.
     - Returns: An array of models that match the given conditions.
     - Throws: An error if the reading operation fails.
     */
    func read<Model: Object>(_ predicate: String? = nil, sorts: [RealmSwift.SortDescriptor] = []) throws -> [Model] {
        let realm = try Realm(configuration: configuration)
        var results = realm.objects(Model.self)
        if let predicate {
            results = results.filter(predicate)
        }
        results = results.sorted(by: sorts)
        return Array(results.prefix(Constants.limit))
    }

    /**
     Reads and returns a model from the database by its primary key.
     - Parameter primaryKey: The primary key of the model to be read.
     - Returns: The model object if found, or `nil` if no object exists with the given primary key.
     - Throws: An error if the reading operation fails.
     */
    func read<Model: Object>(primaryKey: Any) throws -> Model? {
        let realm = try Realm(configuration: configuration)
        return realm.object(ofType: Model.self, forPrimaryKey: primaryKey)
    }

    /**
     Observes changes in the database based on a specified predicate and sorting, triggering the handler when changes occur.
     - Parameters:
     - predicate: A string filter to specify conditions for observing data changes. Can be `nil` to observe all objects of the model type.
     - sorts: An array of sort descriptors used to sort the observed results.
     - handler: A callback function that is invoked when changes occur. The result is either an array of models or an error.
     - Returns: A `NotificationToken` used to manage the observation.
     - Throws: An error if the observation setup fails.
      */
    func observe<Model: Object>(
        _ predicate: String?,
        sorts: [RealmSwift.SortDescriptor],
        handler: @escaping ValueCallback<Result<[Model], AppError>>
    ) throws -> NotificationToken {
        let realm = try Realm(configuration: configuration)
        var results = realm.objects(Model.self)
        if let predicate {
            results = results.filter(predicate)
        }
        results = results.sorted(by: sorts)
        return results.observe {
            switch $0 {
            case .initial(let results):
                handler(.success(Array(results)))
            case .update(let results, deletions: _, insertions: _, modifications: _):
                handler(.success(Array(results)))
            case .error(let error):
                handler(.failure(AppError.error(error)))
            }
        }
    }

    /**
     Performs an update operation within a write transaction.
     - Parameter handler: A closure containing the update logic to be executed.
     - Throws: An error if the update operation fails.
     */
    func update(_ handler: () -> Void) throws {
        let realm = try Realm(configuration: configuration)
        try realm.write(handler)
    }

    /**
     Deletes multiple instances of a model from the database.
     - Parameter items: The instances of the model to be deleted. Accepts one or more models of the specified type.
     - Throws: An error if the deletion operation fails.
     */
    func delete<Model: Object>(_ items: Model...) throws {
        try delete(items)
    }

    /**
     Deletes an array of model instances from the database.
     - Parameter items: An array of models to be deleted.
     - Throws: An error if the deletion operation fails.
     */
    func delete<Model: Object>(_ items: [Model]) throws {
        let realm = try Realm(configuration: configuration)
        try realm.write {
            for item in items {
                realm.delete(item)
            }
        }
    }
}
