//
//  CoordModel.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation
import RealmSwift

// MARK: - CoordModel

class CoordModel: Object, Codable {
    @Persisted var lon: Double = 0
    @Persisted var lat: Double = 0
}
