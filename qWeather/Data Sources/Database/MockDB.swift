//
//  MockDB.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation
import SwiftData

final class MockDB: Database {
    typealias Model = Any
    
    func create<Model>(_ items: Model...) throws {
        throw AppError.unimplemented
    }
    
    func create<Model>(_ items: [Model]) throws {
        throw AppError.unimplemented
    }
    
    func read<Model>() throws -> [Model] {
        throw AppError.unimplemented
    }
    
    func update<Model>(_ item: Model) throws {
        throw AppError.unimplemented
    }
    
    func delete<Model>(_ items: Model...) throws {
        throw AppError.unimplemented
    }
    
    func delete<Model>(_ items: [Model]) throws {
        throw AppError.unimplemented
    }
}
