//
//  AccountCreationSalutationViewModel.swift
//  m-login-app
//
//  Created by Normann Joseph on 24.07.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import Foundation
import Combine

enum SalutationOptions {
    case MR, MRS, DIVERSE

    var displayValue: String {
        switch self {
        case .MR:
            return String.localized(key: "Mr")
        case .MRS:
            return String.localized(key: "Mrs")
        case .DIVERSE:
            return String.localized(key: "Diverse")
        }
    }

    var value: String {
        switch self {
        case .MR:
            return "HERR"
        case .MRS:
            return "FRAU"
        case .DIVERSE:
            return "DIVERS"
        }
    }
}

class AccountCreationSalutationViewModel {


    let skipButtonText = String.localized(key: "ButtonSkip")
    let salutationLabelText = String.localized(key: "SalutationLabel")
    let salutationOptions = [SalutationOptions.MR,
                             SalutationOptions.MRS,
                             SalutationOptions.DIVERSE]

    let salutationTitleLabelText = String.localized(key: "SalutationTitleLabel")

    var selectedSalutationOption: SalutationOptions = .MR
    var selectedSalutatuionValue: String {
        selectedSalutationOption.value
    }

    lazy var numberOfSalutationOptions: Int = {
        salutationOptions.count
    }()

    func salutationOption(at index: Int) -> String {
        guard index >= 0, index < numberOfSalutationOptions else {
            return "-"
        }
        let salutaionOption = salutationOptions[index]
        return salutaionOption.displayValue
    }

    func salutationOptionSelected(at index: Int) {
        selectedSalutation = salutationOption(at: index)
        selectedSalutationOption = salutationOptions[index]
    }

    var selectedSalutation: String? = nil {
        didSet {
            guard let selectedSalutation = selectedSalutation else { return }
            salutationValidator.send(!selectedSalutation.isEmpty)
        }
    }

    let salutationValidator = CurrentValueSubject<Bool, Never>(false)

}
