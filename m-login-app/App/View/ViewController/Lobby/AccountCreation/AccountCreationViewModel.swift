//
//  AccountCreationViewModel.swift
//  m-login-app
//
//  Created by Normann Joseph on 23.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

enum AccountCreationContext {
    case externalAppRequirement, mLoginLover
}

enum AccountCreationStep: Int, CaseIterable {
    case email = 1
    case password
    case salutation
    case name
    case dateOfBirth
    case country
    case city
    case address
    case phone
    case legal
    case optin
    case victory

    //TODO: Add content into localized strings
    var metaInfo: AccountCreationStepMetaInfo {

        let numberOfValues = AccountCreationStep.allCases.count - 1

        switch self {
        case .email:
            return  AccountCreationStepMetaInfo(title: String.localized(key: "RegStep1"),
                                                subline: String.localized(key: "RegStep1Title"),
                                                percentageDone:CGFloat(self.rawValue) / CGFloat(numberOfValues),
                                                cardTitle: String.localized(key: "EMailCardTitle"))
        case .password:
            return  AccountCreationStepMetaInfo(title: String.localized(key: "RegStep1"),
                                                subline: String.localized(key: "RegStep1Title"),
                                                percentageDone: CGFloat(self.rawValue) / CGFloat(numberOfValues),
                                                cardTitle: String.localized(key: "PasswordCardTitle"))
        case .salutation:
            return  AccountCreationStepMetaInfo(title: String.localized(key: "RegStep2"),
                                                subline: String.localized(key: "RegStep2Title"),
                                                percentageDone: CGFloat(self.rawValue) / CGFloat(numberOfValues),
                                                cardTitle: String.localized(key: "SalutationCardTitle"))
        case .name:
            return  AccountCreationStepMetaInfo(title: String.localized(key: "RegStep2"),
                                                subline: String.localized(key: "RegStep2Title"),
                                                percentageDone: CGFloat(self.rawValue) / CGFloat(numberOfValues),
                                                cardTitle: String.localized(key: "NameCardTitle"))
        case .dateOfBirth:
            return  AccountCreationStepMetaInfo(title: String.localized(key: "RegStep2"),
                                                subline: String.localized(key: "RegStep2Title"),
                                                percentageDone: CGFloat(self.rawValue) / CGFloat(numberOfValues),
                                                cardTitle: String.localized(key: "DobCardTitle"))
        case .country:
            return  AccountCreationStepMetaInfo(title: String.localized(key: "RegStep3"),
                                                subline: String.localized(key: "RegStep3Title"),
                                                percentageDone: CGFloat(self.rawValue) / CGFloat(numberOfValues),
                                                cardTitle: String.localized(key: "CountryCardTitle"))
        case .city:
            return  AccountCreationStepMetaInfo(title: String.localized(key: "RegStep3"),
                                                subline: String.localized(key: "RegStep3Title"),
                                                percentageDone: CGFloat(self.rawValue) / CGFloat(numberOfValues),
                                                cardTitle: String.localized(key: "CityCardTitle"))
        case .address:
            return  AccountCreationStepMetaInfo(title: String.localized(key: "RegStep3"),
                                                subline: String.localized(key: "RegStep3Title"),
                                                percentageDone: CGFloat(self.rawValue) / CGFloat(numberOfValues),
                                                cardTitle: String.localized(key: "AddressCardTitle"))
        case .phone:
            return  AccountCreationStepMetaInfo(title: String.localized(key: "RegStep3"),
                                                subline: String.localized(key: "RegStep3Title"),
                                                percentageDone: CGFloat(self.rawValue) / CGFloat(numberOfValues),
                                                cardTitle: String.localized(key: "MobileCardTitle"))
        case .legal:
            var title = AccountCreationStepMetaInfo(title: String.localized(key: "RegStep4"),
                                                subline: String.localized(key: "RegStep4Title"),
                                                percentageDone: CGFloat(self.rawValue) / CGFloat(numberOfValues),
                                                cardTitle: String.localized(key: "LegalCardTitle"))
            title.sublineAlternative = String.localized(key: "RegStep4TitleAGBOnly")
            return title
        case .optin:
            return  AccountCreationStepMetaInfo(title: String.localized(key: "RegStep5"),
                                                subline: String.localized(key: "RegStep5Title"),
                                                percentageDone: CGFloat(self.rawValue) / CGFloat(numberOfValues),
                                                cardTitle: String.localized(key: "DataAccessTitle"))
        case .victory:
            return  AccountCreationStepMetaInfo(title: "",
                                                subline: "",
                                                percentageDone: 1.0,
                                                cardTitle: String.localized(key: "VictoryTitle"))

        }
    }
}

struct AccountCreationStepMetaInfo {
    let title: String
    let subline: String
    let percentageDone: CGFloat
    let cardTitle: String
    var sublineAlternative: String? = nil
}

class AccountCreationViewModel {

    let accountCreationContext: AccountCreationContext

    var initialBottomConstraintConstant: CGFloat = 0.0

    var navigationController: LobbyNavigationController?
    var progressBar: ProgressBarView?
    
    var creationStep: AccountCreationStep = .email {
        didSet {
            let metaInfo = creationStep.metaInfo
            var sublineText = metaInfo.subline
            if accountCreationContext == AccountCreationContext.mLoginLover {
                sublineText = metaInfo.sublineAlternative ?? metaInfo.subline
            }

            navigationController?.setHeader(title: metaInfo.title, subline: sublineText)
            progressBar?.percentage = metaInfo.percentageDone
        }
    }

    var cardTitle: String {
        creationStep.metaInfo.cardTitle
    }

    init(accountCreationContext: AccountCreationContext) {
        self.accountCreationContext = accountCreationContext
    }


    //MANDATORY USER INPUT
    var emailAddress: String?
    //TBD: store as hashed string?!
    var password: String?

    //MANDATORY IF NOT SKIPPED
    var salutation: String?
    var firstName: String?
    var lastName: String?

    //ISO8601 String of date required by the backend
    var dateOfBirth: String?

    var userRegion: String?
    var country: String?

    var zipCode: String?
    var city: String?

    var street: String?
    var streetNumber: String?
    var additionalAddress: String?

    var mobileNumber: String?

    var didConfirmAGB = false
    var didGrantScopes = false

    var didOptinNewsletter = false
    var didOptinMarketing = false
    var didOptinOffers = false
    var didOptinOffersNewsletter = false

    //OPTIONALS
    var salutationTitle: String?



}
