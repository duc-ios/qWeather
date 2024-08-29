//
//  DB.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation
import RealmSwift

// MARK: - DB

protocol DB {
    func create<Model: Object>(_ items: Model...) throws
    func create<Model: Object>(_ items: [Model]) throws
    func read<Model: Object>(primaryKey: Any) throws -> Model?
    func read<Model: Object>(_ predicate: String?) throws -> [Model]
    func update(_ handler: () -> Void) throws
    func delete<Model: Object>(_ items: Model...) throws
    func delete<Model: Object>(_ items: [Model]) throws
}
