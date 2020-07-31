//
//  AccountCreationCityViewModel.swift
//  m-login-app
//
//  Created by Normann Joseph on 24.07.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import Combine
import Foundation

class AccountCreationCityViewModel {

    private struct Constants {
        static let minimumLength: Int = 1
        static let germanZipCodeLength = 5
        static let germany = "DE"
    }

    let cityTextFieldText = String.localized(key: "CityLabel")
    let zipCodeTextFieldText = String.localized(key: "ZIPLabel")

    var userRegion: String?

    var zipCode = "" {
        didSet {
            zipCodeValidator.send(isValidZipInput(zipCode))
        }
    }

    var city = "" {
        didSet {
            cityValidator.send(isValidCityInput(city))
        }
    }

    let zipCodeValidator = CurrentValueSubject<Bool, Never>(false)
    let cityValidator = CurrentValueSubject<Bool, Never>(false)

    //min 2 charachters
    private func isValidCityInput(_ input: String) -> Bool {
        return input.count >= Constants.minimumLength
    }

    private func isValidZipInput(_ input: String) -> Bool {

        if userRegion == Constants.germany {
            return input.count == Constants.germanZipCodeLength
        } else {
            return input.count >= Constants.minimumLength
        }

    }
}
