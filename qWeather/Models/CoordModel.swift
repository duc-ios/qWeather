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
    convenience init(lon: Double = 0, lat: Double = 0) {
        self.init()
        self.lon = lon
        self.lat = lat
    }
    
    @Persisted var lon: Double = 0
    @Persisted var lat: Double = 0
}
