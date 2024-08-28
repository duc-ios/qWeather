//
//  RealmDatabase.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation
import RealmSwift

// MARK: - RealmDatabase

final class RealmDatabase {
    static func configure() {
        
    }
    
    func create<Model: Object>(_ items: Model...) throws {
        try create(items)
    }

    func create<Model: Object>(_ items: [Model]) throws {
        let realm = try Realm()
        try realm.write {
            for item in items {
                realm.add(item)
            }
        }
    }

    func read<Model: Object>(predicateFormat: String? = nil, args: Any...) throws -> [Model] {
        let realm = try Realm()
        var results = realm.objects(Model.self)
        if let predicateFormat {
           results = results.filter(predicateFormat, args)
        }
        return Array(results.prefix(10))
    }
    
    func read<Model: Object>(primayKey: Any) throws -> Model? {
        let realm = try Realm()
        return realm.object(ofType: Model.self, forPrimaryKey: primayKey)
    }

    func update(_ handler: () -> Void) throws {
        let realm = try Realm()
        try realm.write(handler)
    }

    func delete<Model: Object>(_ items: Model...) throws {
        try delete(items)
    }

    func delete<Model: Object>(_ items: [Model]) throws {
        let realm = try Realm()
        try realm.write {
            for item in items {
                realm.delete(item)
            }
        }
    }
}
