//
//  VerbosePlugin.swift
//  qWeather
//
//  Created by Duc on 1/9/24.
//

import Foundation
import Moya
import SwiftyJSON

// MARK: - VerbosePlugin

struct VerbosePlugin: PluginType {
    let verbose: Bool

    func prepare(_ request: URLRequest, target _: TargetType) -> URLRequest {
        if verbose {
            logger.debug("\(request.httpMethod ?? ""): \(request.url?.absoluteString ?? "")")
            if let body = request.httpBody,
               let str = String(data: body, encoding: .utf8)
            {
                logger.debug("BODY: \(str))")
            }
        }
        return request
    }

    func didReceive(_ result: Result<Response, MoyaError>, target _: TargetType) {
        switch result {
        case let .success(body):
            if verbose {
                logger.debug("RESPONSE:")
                if let json = JSON(body.data).rawString() {
                    logger.debug("\(json)")
                } else {
                    let response = String(data: body.data, encoding: .utf8)!
                    logger.debug("\(response)")
                }
            }
        case .failure:
            break
        }
    }
}
