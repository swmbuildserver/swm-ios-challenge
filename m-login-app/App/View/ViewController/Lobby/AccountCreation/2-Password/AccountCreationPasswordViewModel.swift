//
//  AccountCreationPasswordViewModel.swift
//  m-login-app
//
//  Created by Normann Joseph on 23.07.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import Combine
import Foundation

class AccountCreationPasswordViewModel {

    var userInput = "" {
        didSet {

            //manage state of condition checkmarks
            lengthConditionValidator.send(!isLengthConditionValid)
            complexityConditionValidator.send(!isComplexityConditionValid)
            longComplexityConditionValidator.send(!isLongComplexityConditionValid)

            //if all reuirements are met, activate proceed
            userInputValidator.send( (isLengthConditionValid && isComplexityConditionValid) || isLongComplexityConditionValid )
        }
    }

    let userInputValidator = CurrentValueSubject<Bool, Never>(false)

    let lengthConditionValidator = CurrentValueSubject<Bool, Never>(false)
    let complexityConditionValidator = CurrentValueSubject<Bool, Never>(false)
    let longComplexityConditionValidator = CurrentValueSubject<Bool, Never>(false)


    var isLengthConditionValid: Bool {
        return userInput.count >= 8
    }

    var isComplexityConditionValid: Bool {
        return complexityLevel(input: userInput) >= 3
    }

    var isLongComplexityConditionValid: Bool {
        return userInput.count >= 12 && complexityLevel(input: userInput) >= 2
    }

    //MARK: private
    private func complexityLevel(input: String) -> Int {
        return  (userInputHasLowercaseLetters ? 1 : 0) +
            (userInputHasUppercaseLetters ? 1 : 0) +
            (userInputHasNumbers ? 1 : 0) +
            (userInputHasSpecialCharacters ? 1 : 0)
    }

    private var userInputHasLowercaseLetters: Bool {
        let regex = ".*[a-z]+.*"
        if NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: userInput) {
            return true
        }
        return false
    }

    private var userInputHasUppercaseLetters: Bool {
        let regex = ".*[A-Z]+.*"
        if NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: userInput) {
            return true
        }
        return false
    }

    private var userInputHasNumbers: Bool {
        let regex = ".*[0-9]+.*"
        if NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: userInput) {
            return true
        }
        return false
    }

    private var userInputHasSpecialCharacters: Bool {
        //This is the Regex from android and web. It seeems not work on iOS, i.e. § is not recognized
        let regex = ".*[\\x21-\\x2F\\x3A-\\x40\\x5B-\\x60\\x7B-\\x7E]+.*"
        //let regex = ".*[$&+,:;=§?@#|'<>.^*()%!-]+.*"
        if NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: userInput) {
            return true
        }
        return false
    }

}
