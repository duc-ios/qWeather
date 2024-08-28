//
//  Codable+Extensions.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation

extension KeyedDecodingContainer {
    /// Some poorly designed APIs return JSON where the type is enclosed in quotes, which means it is interpreted as a String.
    /// These two methods will attempt to decode the supplied type conforming to LosslessStringConvertible by first decoding the String
    /// and then converting to the supplied type.
    func decodeFromString<T>(_: T.Type, forKey key: K) throws -> T where T: LosslessStringConvertible {
        let string = try decode(String.self, forKey: key)
        guard let value = T(string) else {
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "decodeFromString failed")
        }
        return value
    }

    func decodeFromStringIfPresent<T>(_ type: T.Type, forKey key: K) throws -> T? where T: LosslessStringConvertible {
        guard contains(key) else { return nil }
        return try decodeFromString(type, forKey: key)
    }

    /// These methods are specializations of the above methods specifically for boolean values. Again poorly designed APIs sometimes return
    /// boolean values as the strings "true" or "false". This method will capture those values and return the proper Bool values.
    func decodeFromString(_: Bool.Type, forKey key: K) throws -> Bool {
        let string = try decode(String.self, forKey: key)
        switch string.lowercased() {
        case "true":
            return true
        case "false":
            return false
        default:
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "decodeFromString for Bool failed")
        }
    }

    func decodeFromStringIfPresent(_: Bool.Type, forKey key: K) throws -> Bool? {
        guard contains(key) else { return nil }
        return try decodeFromString(Bool.self, forKey: key)
    }

    /// Some poorly designed APIs will contain values for keys that could be either a single instance of a type *or* an array of that type.
    /// These methods will first attempt to decode an array of the supplied type, if that fails it will attempt to decode a a single instance
    /// of the supplied type and return it in a containing array.
    func decodeItemOrArray<T>(_: T.Type, forKey key: K) throws -> [T] where T: Decodable {
        if let _ = try? nestedUnkeyedContainer(forKey: key) {
            return try decode([T].self, forKey: key)
        } else {
            return try [decode(T.self, forKey: key)]
        }
    }

    func decodeItemOrArrayIfPresent<T>(_ type: T.Type, forKey key: K) throws -> [T]? where T: Decodable {
        guard contains(key) else { return nil }
        return try decodeItemOrArray(type, forKey: key)
    }

    func decodeIfPresent<T>(_ key: K) throws -> T? where T: Decodable {
        guard contains(key) else { return nil }
        return try decode(T.self, forKey: key)
    }

    func decode<T>(_ key: K) throws -> T where T: Decodable {
        return try decode(T.self, forKey: key)
    }

    func decode<T>(_ key: K, default: T) -> T where T: Decodable {
        return (try? decode(T.self, forKey: key)) ?? `default`
    }
}
