//
//  AppConstants.swift
//  m-login-app
//
//  Created by Normann Joseph on 21.07.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

typealias AnimationDuration = TimeInterval
extension AnimationDuration {
    static let standard = 0.25
    static let fast = 0.15
}

typealias Delay = TimeInterval
extension Delay {
    static let none = 0.0
}

typealias Visibility = CGFloat
extension Visibility {
    static let hidden = CGFloat(0.0)
    static let visible = CGFloat(1.0)
    static let defaultFaded = CGFloat(0.7)
}
