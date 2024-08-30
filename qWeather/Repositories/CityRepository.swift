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
    func create(_ items: CityModel...) throws
    func create(_ items: [CityModel]) throws
    func read(primaryKey: Any) throws -> CityModel?
    func read(_ predicate: String?, sorts: [(keyPath: String, asc: Bool)]) throws -> [CityModel]
    func update(_ handler: VoidCallback) throws
    func delete(_ items: CityModel...) throws
    func delete(_ items: [CityModel]) throws
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
