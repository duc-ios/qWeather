//
//  Database.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation

protocol Database {
    associatedtype Model
    func create(_ items: Model...) throws
    func create(_ items: [Model]) throws
    func read() throws -> [Model]
    func update(_ item: Model) throws
    func delete(_ items: Model...) throws
    func delete(_ items: [Model]) throws
}
