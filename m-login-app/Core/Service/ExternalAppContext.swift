//
//  ExternalAppContext.swift
//  m-login-app
//
//  Created by Normann Joseph on 03.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import Foundation

public enum RequestedAppAction: String {
    case login
    case signup
    case paymentmethods
    case scopeChange
}

struct ExternalAppContext {
    let absoluteUrl: String
    let requestedAction: RequestedAppAction?
    let sourceApplicationBundle: String

    let options = [String: String]()
}
