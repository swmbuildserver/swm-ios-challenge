//
//  AccountCreationOptinViewModel.swift
//  m-login-app
//
//  Created by Normann Joseph on 24.07.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import Foundation

class AccountCreationOptinViewModel {

    var didOptinNewsletter = false
    var didOptinMarketing = false
    var didOptinOffers = false
    var didOptinOffersNewsletter = false

    let subHeadlineLabelText = String.localized(key: "OptinSubline")
    let privacyNeedle = String.localized(key: "DatenschutzInfosNeedle")
    let privacyURLString = String.localized(key: "PrivacyURL")

    let newsletterHeadlineLabelText = String.localized(key: "NewsletterSwitchTitle")
    let newsletterDescriptionLabelText = String.localized(key: "NewsletterSwitchText")

    let marketingHeadlineLabelText = String.localized(key: "AnalyticsSwitchTitle")
    let marketingDescriptionLabelText = String.localized(key: "AnalyticsSwitchText")

    let offersHeadlineLabelText = String.localized(key: "OffersSwitchTitle")
    let offersDescriptionLabelText = String.localized(key: "OffersSwitchText")

    let offersMailOptinLabelText = String.localized(key: "OffersSwitchAddendumText")

    let profilingNeedle = String.localized(key: "ProfilingNeedle")
    let optinNeedle = String.localized(key: "OptinNeedle")
    let servicesNeedle = String.localized(key: "ServicesNeedle")
    let placeholderURLString = String.localized(key: "PlaceholderUrlString")

    let secureTransferLabelText = String.localized(key: "DataInfo")

    let proceedButtonText = String.localized(key: "CompleteRegistrationButtonTitle")
}
