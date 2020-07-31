//
//  AccountCreationOptinViewController.swift
//  m-login-app
//
//  Created by Normann Joseph on 26.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

class AccountCreationOptinViewController: AccountCreationBaseViewController {

    private struct Constants {
        static let bottomConstraintValue: CGFloat = 44.0
    }
    
    @IBOutlet weak var subHeadlineTextView: UITextView!

    @IBOutlet weak var newsletterSwitch: UISwitch!
    @IBOutlet weak var newsletterHeadlineLabel: UILabel!
    @IBOutlet weak var newsletterDescriptionLabel: UILabel!

    @IBOutlet weak var marketingSwitch: UISwitch!
    @IBOutlet weak var marketingHeadlineLabel: UILabel!
    @IBOutlet weak var marketingDescriptionLabel: UILabel!

    @IBOutlet weak var offersSwitch: UISwitch!
    @IBOutlet weak var offersHeadlineLabel: UILabel!
    @IBOutlet weak var offersTextView: UITextView!

    @IBOutlet weak var offersMailOptinSwitch: UISwitch!
    @IBOutlet weak var offersMailOptinTextView: UITextView!

    @IBOutlet weak var secureTransferLabel: UILabel!

    var viewModel: AccountCreationOptinViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        accountCreationViewModel.creationStep = .optin
        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        accountCreationViewModel.creationStep = .optin
    }

    override func setupViews() {
        super.setupViews()
        bottomSpaceConstraint.constant = Constants.bottomConstraintValue
        proceedButton.isActive = true
        offersMailOptinSwitch.isEnabled = false
        newsletterSwitch.isOn = accountCreationViewModel.didOptinNewsletter
        marketingSwitch.isOn = accountCreationViewModel.didOptinMarketing
        offersSwitch.isOn = accountCreationViewModel.didOptinOffers
        offersMailOptinSwitch.isOn = accountCreationViewModel.didOptinOffersNewsletter
        setupLabels()
    }

    private func setupLabels() {


        newsletterHeadlineLabel.text = viewModel.newsletterHeadlineLabelText
        newsletterDescriptionLabel.text = viewModel.newsletterDescriptionLabelText

        marketingHeadlineLabel.text = viewModel.marketingHeadlineLabelText
        marketingDescriptionLabel.text = viewModel.marketingDescriptionLabelText

        offersHeadlineLabel.text = viewModel.offersHeadlineLabelText
        offersTextView.text = viewModel.offersDescriptionLabelText
        offersMailOptinTextView.text = viewModel.offersMailOptinLabelText
        offersMailOptinTextView.alpha = Visibility.defaultFaded
        offersMailOptinTextView.isUserInteractionEnabled = false

        secureTransferLabel.text = viewModel.secureTransferLabelText
        proceedButton.titleLabel.text = viewModel.proceedButtonText

        setupAttributedText()

        offersTextView.font = UIFont.copy2SfProDisplayGrey
        offersMailOptinTextView.font = UIFont.copy2SfProDisplayGrey
        subHeadlineTextView.font = UIFont.copy2SfProDisplayGrey
    }

    private func setupAttributedText() {

        createLinkInTextView(inputText: viewModel.subHeadlineLabelText,
                             needles: [viewModel.privacyNeedle: viewModel.privacyURLString],
                             targetView: subHeadlineTextView)

        createLinkInTextView(inputText: viewModel.offersDescriptionLabelText,
                             needles: [viewModel.profilingNeedle: viewModel.placeholderURLString,
                                      viewModel.optinNeedle: viewModel.placeholderURLString],
                             targetView: offersTextView)

        createLinkInTextView(inputText: viewModel.offersMailOptinLabelText,
                             needles: [viewModel.servicesNeedle: viewModel.placeholderURLString],
                             targetView: offersMailOptinTextView)
    }

    @IBAction func userDidChangeNewsletterSwitch(_ sender: Any) {
        viewModel.didOptinNewsletter = newsletterSwitch.isOn
    }

    @IBAction func userDidChangeMarketingSwitch(_ sender: Any) {
        viewModel.didOptinMarketing = marketingSwitch.isOn
    }

    @IBAction func userDidChangeOffersSwitch(_ sender: Any) {
        viewModel.didOptinOffers = offersSwitch.isOn
        if offersSwitch.isOn {
            offersMailOptinSwitch.isEnabled = true
            offersMailOptinTextView.alpha = Visibility.visible
            offersMailOptinTextView.isUserInteractionEnabled = true
        } else {
            offersMailOptinSwitch.setOn(false, animated: true)
            viewModel.didOptinOffersNewsletter = false
            offersMailOptinSwitch.isEnabled = false
            offersMailOptinTextView.alpha = Visibility.defaultFaded
            offersMailOptinTextView.isUserInteractionEnabled = false
        }
    }

    @IBAction func userDidChangeOffersNewsletterSwitch(_ sender: Any) {
        viewModel.didOptinOffersNewsletter = offersMailOptinSwitch.isOn
    }

    override func userDidTapProceedButton(_ sender: Any) {
        accountCreationViewModel.didOptinNewsletter = viewModel.didOptinNewsletter
        accountCreationViewModel.didOptinMarketing = viewModel.didOptinMarketing
        accountCreationViewModel.didOptinOffers = viewModel.didOptinOffers
        accountCreationViewModel.didOptinOffersNewsletter = viewModel.didOptinOffersNewsletter
        super.userDidTapProceedButton(sender)
    }

}
