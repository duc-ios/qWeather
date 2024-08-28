//
//  JSON+Extensions.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation
import SwiftyJSON

extension JSONDecoder {
    private static let association = ObjectAssociation<JSONDecoder>()

    static var snakeCase: JSONDecoder {
        get {
            if let decoder = JSONDecoder.association[self] {
                return decoder
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            JSONDecoder.association[self] = decoder
            return decoder
        }
        set { JSONDecoder.association[self] = newValue }
    }
}

extension JSONEncoder {
    private static let association = ObjectAssociation<JSONEncoder>()

    static var snakeCase: JSONEncoder {
        get {
            if let decoder = JSONEncoder.association[self] {
                return decoder
            }
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            JSONEncoder.association[self] = encoder
            return encoder
        }
        set { JSONEncoder.association[self] = newValue }
    }
}

extension Decodable {
    init(_ data: Any) throws {
        let data = try (data as? Data) ?? (JSON(data).rawData())
        self = try JSONDecoder.snakeCase.decode(Self.self, from: data)
    }
}

extension Encodable {
    func rawData() throws -> Data {
        try JSONEncoder.snakeCase.encode(self)
    }
}
