//
//  AccountCreationAddressViewModel.swift
//  m-login-app
//
//  Created by Normann Joseph on 24.07.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import Combine
import Foundation

class AccountCreationAddressViewModel {

let streetTextFieldLabelText = String.localized(key: "StreetLabel")
let numberTextFieldLabelText = String.localized(key: "NumberLabel")
let additionalTextFieldLabelText = String.localized(key: "AdditionalAddressLabel")

    private struct Constants {
        static let minimumLength: Int = 1
    }

    var street = "" {
        didSet {
            streetValidator.send(isValidInput(street))
        }
    }

    var streetNumber = "" {
        didSet {
            streetNumberValidator.send(isValidInput(streetNumber))
        }
    }

    var additionalAddress: String? = nil

    let streetValidator = CurrentValueSubject<Bool, Never>(false)
    let streetNumberValidator = CurrentValueSubject<Bool, Never>(false)

    //min 2 charachters
    private func isValidInput(_ input: String) -> Bool {
        return input.count >= Constants.minimumLength
    }

}
