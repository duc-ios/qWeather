//
//  MockDB.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation
import RealmSwift

// MARK: - MockDB

struct MockDB: DB {
    typealias Model = Object

    func create<Model>(_ items: Model...) throws {
        throw AppError.unimplemented
    }

    func create<Model>(_ items: [Model]) throws {
        throw AppError.unimplemented
    }

    func read<Model>(primaryKey: Any) throws -> Model? {
        throw AppError.unimplemented
    }
    
    func read<Model>(_ predicate: String?) throws -> [Model] {
        throw AppError.unimplemented
    }

    func update(_ handler: () -> Void) throws {
        throw AppError.unimplemented
    }

    func delete<Model>(_ items: Model...) throws {
        throw AppError.unimplemented
    }

    func delete<Model>(_ items: [Model]) throws {
        throw AppError.unimplemented
    }
}
