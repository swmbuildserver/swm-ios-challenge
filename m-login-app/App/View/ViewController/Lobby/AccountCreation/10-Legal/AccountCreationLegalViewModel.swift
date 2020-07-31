//
//  AccountCreationLegalViewModel.swift
//  m-login-app
//
//  Created by Normann Joseph on 24.07.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import Combine
import Foundation

class AccountCreationLegalViewModel {

    let agbText = String.localized(key: "AGBSwitchLabel")
    let agbNeedle = String.localized(key: "LegalAGBNeedle")
    let agbURLString = String.localized(key: "LegalURL")
    let externalAppAccessText = String.localized(key: "DataAccessSwitchLabel")
    let externalAppAccessDetailsText = String.localized(key: "Create some magic text when Scope Handling is clear")

    let accountCreationContext: AccountCreationContext
    
    init(accountCreationContext: AccountCreationContext) {
        self.accountCreationContext = accountCreationContext
    }

    var didConfirmAGB = false {
        didSet {
            if accountCreationContext == .mLoginLover {
                userInputValidator.send(didConfirmAGB)
            } else {
                userInputValidator.send(didConfirmAGB && didGrantScopes)
            }
        }
    }

    var didGrantScopes = false {
        didSet {
            userInputValidator.send(didConfirmAGB && didGrantScopes)
        }
    }

    let userInputValidator = CurrentValueSubject<Bool, Never>(false)
}
