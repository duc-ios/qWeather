//
//  WeatherModel.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation

// MARK: - WeatherModel

struct WeatherModel: Codable, Equatable {
    let coord: CoordModel
    let weather: [WeatherDetailModel]
    let main: MainModel
    @Kilometter var visibility: String
    let wind: WindModel
    @DateTime var dt: Date
    let sys: SysModel
    let name: String
}

// MARK: - CoordModel

struct CoordModel: Codable, Equatable {
    let lon, lat: Double
}

// MARK: - MainModel

struct MainModel: Codable, Equatable {
    @Celcius var temp: String
    @Celcius var feelsLike: String
    @Celcius var tempMin: String
    @Celcius var tempMax: String
    @Percent var humidity: String
    @Pressure var pressure: String
}

// MARK: - SysModel

struct SysModel: Codable, Equatable {
    let country: String
    @DateTime var sunrise: Date
    @DateTime var sunset: Date
}

// MARK: - WeatherDetailModel

struct WeatherDetailModel: Codable, Equatable {
    let main, description: String
    @WeatherIcon var icon: URL?
}

// MARK: - WindModel

struct WindModel: Codable, Equatable {
    @Speed var speed: String
    @Compass var deg: String
}

// MARK: - Speed

@propertyWrapper
struct Speed: Codable, Equatable {
    var projectedValue: Double
    var wrappedValue: String

    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        projectedValue = try container.decode(Double.self)
        wrappedValue = "\(projectedValue)m/s"
    }
}

// MARK: - Celcius

@propertyWrapper
struct Celcius: Codable, Equatable {
    var projectedValue: Double
    var wrappedValue: String

    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        projectedValue = try container.decode(Double.self)
        wrappedValue = String(format: "%.2f°C", projectedValue - 273.15)
    }
}

// MARK: - Compass

@propertyWrapper
struct Compass: Codable, Equatable {
    var projectedValue: Double
    var wrappedValue: String

    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        projectedValue = try container.decode(Double.self)
        let val = floor((projectedValue / 22.5) + 0.5)
        let arr = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        wrappedValue = arr[Int(val) % 16]
    }
}

// MARK: - DateTime

@propertyWrapper
struct DateTime: Codable, Equatable {
    var projectedValue: TimeInterval
    var wrappedValue: Date

    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        projectedValue = try container.decode(TimeInterval.self)
        wrappedValue = Date(timeIntervalSince1970: projectedValue)
    }
}

// MARK: - WeatherIcon

@propertyWrapper
struct WeatherIcon: Codable, Equatable {
    var projectedValue: String
    var wrappedValue: URL?

    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        projectedValue = try container.decode(String.self)
        wrappedValue = URL(string: "https://openweathermap.org/img/wn/\(projectedValue)@4x.png")
    }
}

// MARK: - Percent

@propertyWrapper
struct Percent: Codable, Equatable {
    var projectedValue: Int
    var wrappedValue: String

    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        projectedValue = try container.decode(Int.self)
        wrappedValue = "\(projectedValue)%"
    }
}

// MARK: - Pressure

@propertyWrapper
struct Pressure: Codable, Equatable {
    var projectedValue: Double
    var wrappedValue: String

    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        projectedValue = try container.decode(Double.self)
        wrappedValue = "\(projectedValue)hPa"
    }
}

// MARK: - Kilometter

@propertyWrapper
struct Kilometter: Codable, Equatable {
    var projectedValue: Double
    var wrappedValue: String

    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        projectedValue = try container.decode(Double.self)
        wrappedValue = "\(projectedValue / 1000)km"
    }
}
