//
//  Moya+Concurency.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation
import Moya

extension MoyaProvider {
    class MoyaConcurrency {
        private let provider: MoyaProvider

        init(provider: MoyaProvider) {
            self.provider = provider
        }

        func request<T: Decodable>(_ target: Target) async throws -> T {
            return try await withCheckedThrowingContinuation { continuation in
                provider.request(target) { result in
                    switch result {
                    case .success(let response):
                        do {
                            let res = try T.self(data: response.data)
                            continuation.resume(returning: res)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }

    var async: MoyaConcurrency {
        MoyaConcurrency(provider: self)
    }
}
