//
//  AccountCreationCountryViewModel.swift
//  m-login-app
//
//  Created by Normann Joseph on 24.07.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import Combine
import Foundation

class AccountCreationCountryViewModel {

    let countryTextFieldLabelText = String.localized(key: "CountryLabel")
    let skipButtonText = String.localized(key: "ButtonSkip")

    /**
     TODO:
     Currently the sorting of allCountries is based upin allIsoCodes.
     This makes a bad alphabetic order, since ZYPERN is CY and therefore listed above Deutschland.

     The solution is good enough for now, but should be improved asap, since this is the worst user experience.

     A quick solution would be to create a custom Locale struct with region codes and display names. this can
     then be sorted easy
     */
    let allIsoCodes: [String] = NSLocale.isoCountryCodes

    //The device specific reginal code - DE as fallback
    lazy var currentLocaleIsoCode: String = {
        return Locale.current.regionCode ?? "DE"
    }()

    /**
     We create the allCountries on purpose by using NSLocale.
     The Portal application uses a json file, containing a list of iso country codes
     This might leed to some edge case incidents in the future, if an iOS user would pick an exotic country which is not present within the file in portal. If this case will ever happen, the iOS App then should
     use the exact same file like the portal web app.
     Since the only clean apporach would be to download the file from the server into the app, we decided to take this risk here, becoause it is very unlikely to happen. The effort of downloading and checking
     the version of such a file would clearly maximize the effort here.
     */
    lazy var allCountries: [String] = {
        let currentLocale = NSLocale(localeIdentifier: currentLocaleIsoCode)
        return allIsoCodes.compactMap({
            currentLocale.displayName(forKey: NSLocale.Key.countryCode, value: $0)
            })
    }()

    var selectedCountry: String? = nil {
        didSet {
            countryValidator.send(selectedCountry != nil)
        }
    }


    let countryValidator = CurrentValueSubject<Bool, Never>(false)

    lazy var numberOfCountries: Int = {
        allCountries.count
    }()

    lazy var currentCountryIsocodeIndex: Int = {
        allIsoCodes.firstIndex(of: currentLocaleIsoCode) ?? 0
    }()


    func country(at index: Int) -> String? {
        guard index > 0, index < numberOfCountries else { return nil }
        return allCountries[index]
    }

}
