//
//  AccountCreationDateOfBirthViewModel.swift
//  m-login-app
//
//  Created by Normann Joseph on 24.07.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import Foundation
import Combine

class AccountCreationDateOfBirthViewModel {

    let displayDateFormat = "dd.MM.yyyy"
    let iso8601Format = "yyyy-MM-dd"

    let dateOfBirthLabelText = String.localized(key: "DobLabel")
    let dateOfBirthPlaceholderText = String.localized(key: "PleaseChoose")

    var userSelectedDate: String? = nil {
        didSet {
            dateOfBirthValidator.send(userSelectedDate != nil)
        }
    }


    let dateOfBirthValidator = CurrentValueSubject<Bool, Never>(false)
}
