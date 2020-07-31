//
//  MLoginCore.swift
//  m-login-app
//
//  Created by Normann Joseph on 06.04.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import Foundation

public class MLoginCore {

    static let shared = MLoginCore()

    lazy var userService = UserDefaultsService()

    var externalAppContext: ExternalAppContext?

    public var dummyValue: String {
        return "Yiha!"
    }

    public func setup() {

    }

    public func teardown() {
        //TODO: Cleanup here, if required
    }

}
