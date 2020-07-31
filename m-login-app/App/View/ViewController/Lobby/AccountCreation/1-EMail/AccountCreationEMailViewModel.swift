//
//  AccountCreationEMailViewModel.swift
//  m-login-app
//
//  Created by Normann Joseph on 21.07.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import Foundation
import Combine

class AccountCreationEMailViewModel {

    let inputFieldLabelText = String.localized(key: "EMailLabel")

    var inputFieldSuccessState = false

    var userInput = "" {
        didSet {
            userInputValidator.send(isValidEmailFormat(userInput))
        }
    }

    let userInputValidator = CurrentValueSubject<Bool, Never>(false)


    private func isValidEmailFormat(_ input: String) -> Bool {

        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,32}"
        if NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: input) {
            return true
        }

        return false
    }
}
