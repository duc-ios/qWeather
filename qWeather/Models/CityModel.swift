//
//  CityModel.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation
import RealmSwift

// MARK: - CityModel

class CityModel: Object, Codable, Identifiable {
    convenience init(
        id: Int = -1,
        name: String = "",
        state: String = "",
        country: String = "",
        coord: CoordModel? = nil,
        isSaved: Bool? = nil)
    {
        self.init()
        self.id = id
        self.name = name
        self.state = state
        self.country = country
        self.coord = coord
        self.isSaved = isSaved
    }

    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var state: String
    @Persisted var country: String
    @Persisted var coord: CoordModel?
    @Persisted var isSaved: Bool?
}
