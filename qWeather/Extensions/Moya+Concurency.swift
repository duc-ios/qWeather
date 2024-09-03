//
//  Moya+Concurency.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation
import Moya
import SwiftyJSON

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
                        switch response.statusCode {
                        case 200..<400: // success
                            do {
                                let res = try T.self(data: response.data)
                                continuation.resume(returning: res)
                            } catch {
                                continuation.resume(throwing: error)
                            }
                        case 401: // unauthenticated
                            continuation.resume(throwing: AppError.unauthenticated)
                        case 400..<500: // error
                            if let message = JSON(response.data)["message"].string {
                                continuation.resume(throwing: AppError.other(code: response.statusCode, message: message))
                            } else {
                                continuation.resume(throwing: AppError.unexpected)
                            }
                        default: // server error
                            continuation.resume(throwing: AppError.unexpected)
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
