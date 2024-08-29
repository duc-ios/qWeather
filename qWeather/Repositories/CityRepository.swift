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
    func read(_ predicate: String) throws -> [CityModel]
    func update(_ handler: VoidCallback) throws
    func delete(_ items: CityModel...) throws
    func delete(_ items: [CityModel]) throws
    func observe(_ predicate: String, handler: @escaping ValueCallback<Result<[CityModel], AppError>>) throws
}

// MARK: - CityRepositoryImp

class CityRepositoryImp: CityRepository {
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
    
    func read(_ predicate: String) throws -> [CityModel] {
        try db.read(predicate)
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

    func observe(_ predicate: String, handler: @escaping ValueCallback<Result<[CityModel], AppError>>) throws {
        try tokens.insert(db.observe(CityModel.self, predicate, handler: {
            switch $0 {
            case .initial(let results):
                handler(.success(Array(results)))
            case .update(let results, deletions: _, insertions: _, modifications: _):
                handler(.success(Array(results)))
            case .error(let error):
                handler(.failure(AppError.error(error)))
            }
        }))
    }
}
