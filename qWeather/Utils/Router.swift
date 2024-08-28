//
//  Router.swift
//  qWeather
//
//  Created by Duc on 29/8/24.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    @Published var path = [Route]()
    
    func show(_ route: Route) {
        path.append(route)
    }
    
    func replace(_ route: Route) {
        path[-1] = route
    }
    
    func pop() {
        path.removeLast()
    }

    func pop(to route: Route) {
        if let idx = path.lastIndex(where: { $0 == route }) {
            path = Array(path[0 ... idx])
        } else if !path.isEmpty {
            path[path.count - 1] = route
        } else {
            path = [route]
        }
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}
