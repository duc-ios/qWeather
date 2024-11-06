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
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var state: String
    @Persisted var country: String
    @Persisted var lat: Double
    @Persisted var lon: Double
    @Persisted var isSaved: Bool?

    convenience init(
        id: Int = -1,
        name: String = "",
        state: String = "",
        country: String = "",
        lat: Double = 0,
        lon: Double = 0,
        isSaved: Bool? = nil
    ) {
        self.init()
        self.id = id
        self.name = name
        self.state = state
        self.country = country
        self.lat = lat
        self.lon = lon
        self.isSaved = isSaved
    }

    enum CodingKeys: CodingKey {
        case id,
             name,
             state,
             country,
             coord
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        state = try container.decode(String.self, forKey: .state)
        country = try container.decode(String.self, forKey: .country)
        let coord = try container.decode([String: Double].self, forKey: .coord)
        lat = coord["lat"] ?? 0
        lon = coord["lon"] ?? 0
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(state, forKey: .state)
        try container.encode(country, forKey: .country)
        try container.encode([
            "lat": lat,
            "lon": lon,
        ], forKey: .coord)
    }
}
