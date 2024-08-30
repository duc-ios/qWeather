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

    init(configuration: Realm.Configuration = .init(deleteRealmIfMigrationNeeded: true)) {
        self.configuration = .init(deleteRealmIfMigrationNeeded: true)
    }

    func create<Model: Object>(_ items: Model...) throws {
        try create(items)
    }

    func create<Model: Object>(_ items: [Model]) throws {
        let realm = try Realm(configuration: configuration)
        try realm.write {
            for item in items {
                realm.add(item)
            }
        }
    }

    func read<Model: Object>(_ predicate: String? = nil, sorts: [RealmSwift.SortDescriptor] = []) throws -> [Model] {
        let realm = try Realm(configuration: configuration)
        var results = realm.objects(Model.self)
        if let predicate {
            results = results.filter(predicate)
        }
        results = results.sorted(by: sorts)
        return Array(results.prefix(Constants.limit))
    }

    func read<Model: Object>(primaryKey: Any) throws -> Model? {
        let realm = try Realm(configuration: configuration)
        return realm.object(ofType: Model.self, forPrimaryKey: primaryKey)
    }

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

    func update(_ handler: () -> Void) throws {
        let realm = try Realm(configuration: configuration)
        try realm.write(handler)
    }

    func delete<Model: Object>(_ items: Model...) throws {
        try delete(items)
    }

    func delete<Model: Object>(_ items: [Model]) throws {
        let realm = try Realm(configuration: configuration)
        try realm.write {
            for item in items {
                realm.delete(item)
            }
        }
    }
}
