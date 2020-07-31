//
//  AccountCreationNameViewModel.swift
//  m-login-app
//
//  Created by Normann Joseph on 24.07.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import Foundation
import Combine

class AccountCreationNameViewModel {

    private struct Constants {
        static let minimumLength: Int = 2
    }

    let firstNameLabelText = String.localized(key: "FirstNameLabel")
    let lastNameLabelText = String.localized(key: "LastNameLabel")

    var firstName = "" {
        didSet {
            firstnameValidator.send(isValidNameInput(firstName))
        }
    }

    var lastName = "" {
        didSet {
            lastnameValidator.send(isValidNameInput(lastName))
        }
    }

    let firstnameValidator = CurrentValueSubject<Bool, Never>(false)
    let lastnameValidator = CurrentValueSubject<Bool, Never>(false)

    //min 2 charachters
    private func isValidNameInput(_ input: String) -> Bool {
        return input.count >= Constants.minimumLength
    }

}
