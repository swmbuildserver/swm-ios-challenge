//
//  PasswordValidator.swift
//  m-login-app
//
//  Created by Normann Joseph on 08.07.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import Foundation


class PasswordValidator {

    enum PasswordState {
        case empty
        case completed
    }

    var state: PasswordState = .empty

    var hasMinLength: Bool {
        return false
    }

    // 3 of 4 kinds of characters
    var hasMinComplexity: Bool {
        return false
    }

    // min length: 12
    // 2 of 4 kinds of characters
    var hasLongComplexity: Bool {
        return false
    }

    var candidate: String = ""
}
