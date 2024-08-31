//
//  VerbosePlugin.swift
//  qWeather
//
//  Created by Duc on 1/9/24.
//

import Moya
import Foundation
import SwiftyJSON

// MARK: - VerbosePlugin

struct VerbosePlugin: PluginType {
    let verbose: Bool

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
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

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let body):
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
