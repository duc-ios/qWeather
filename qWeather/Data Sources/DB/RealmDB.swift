//
//  RealmDB.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation
import RealmSwift

// MARK: - RealmDB

struct RealmDB: DB {
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

    func read<Model: Object>(_ predicate: String? = nil) throws -> [Model] {
        let realm = try Realm(configuration: configuration)
        var results = realm.objects(Model.self)
        if let predicate {
            results = results.filter(predicate)
        }
        return Array(results.prefix(10))
    }

    func read<Model: Object>(primaryKey: Any) throws -> Model? {
        let realm = try Realm(configuration: configuration)
        return realm.object(ofType: Model.self, forPrimaryKey: primaryKey)
    }
    
    func observe<Model: Object>(_ type: Model.Type, _ predicate: String? = nil, handler: @escaping ValueCallback<RealmCollectionChange<Results<Model>>>) throws -> NotificationToken {
        let realm = try Realm(configuration: configuration)
        var results = realm.objects(Model.self)
        if let predicate {
            results = results.filter(predicate)
        }
        return results.observe(handler)
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
