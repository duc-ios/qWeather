//
//  UINavigationController+Extensions.swift
//  qWeather
//
//  Created by Duc on 18/9/24.
//

import UIKit

extension UINavigationController {
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}
