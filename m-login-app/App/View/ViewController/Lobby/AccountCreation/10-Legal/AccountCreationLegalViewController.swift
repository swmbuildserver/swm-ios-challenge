//
//  AccountCreationLegalViewController.swift
//  m-login-app
//
//  Created by Normann Joseph on 26.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

class AccountCreationLegalViewController: AccountCreationBaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var agbTextView: UITextView!
    @IBOutlet weak var agbSwitch: UISwitch!

    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var externalAppAccessSwitch: UISwitch!
    @IBOutlet weak var externalAppAccessLabel: UILabel!
    @IBOutlet weak var externalAppAccessDetailsLabel: UILabel!
    @IBOutlet weak var detailsImageView: UIImageView!

    var viewModel: AccountCreationLegalViewModel!
    @IBOutlet weak var externalAppInfosConstraint: NSLayoutConstraint!
    @IBOutlet weak var defaultButtonConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        accountCreationViewModel.creationStep = .legal
        setupViews()
        bindViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        accountCreationViewModel.creationStep = .legal
        let detailsImageViewTap = UITapGestureRecognizer(target: self, action: #selector(userDidTapInfoButton(_:)))
        detailsImageViewTap.delegate = self
        detailsImageView.addGestureRecognizer(detailsImageViewTap)
    }

    override func setupViews() {
        super.setupViews()

        createLinkInTextView(inputText: viewModel.agbText,
                             needles: [viewModel.agbNeedle: viewModel.agbURLString],
                             targetView: agbTextView)

        agbTextView.font = UIFont.copy1SfProDisplayDark

        viewModel.didGrantScopes = accountCreationViewModel.didGrantScopes
        viewModel.didConfirmAGB = accountCreationViewModel.didConfirmAGB
        agbSwitch.isOn = viewModel.didConfirmAGB
        externalAppAccessSwitch.isOn = viewModel.didGrantScopes


        if viewModel.accountCreationContext == .externalAppRequirement {
            defaultButtonConstraint.isActive = false
            externalAppAccessLabel.text = viewModel.externalAppAccessText
            externalAppAccessDetailsLabel.text = viewModel.externalAppAccessDetailsText
            detailsImageView.isUserInteractionEnabled = true

        } else {
            defaultButtonConstraint.isActive = true
            defaultButtonConstraint.constant = externalAppInfosConstraint.constant
            externalAppInfosConstraint.isActive = false
            separatorView.removeFromSuperview()
            externalAppAccessSwitch.removeFromSuperview()
            externalAppAccessLabel.removeFromSuperview()
            externalAppAccessDetailsLabel.removeFromSuperview()
            detailsImageView.removeFromSuperview()
        }
    }

    private func bindViews() {
        viewModel.userInputValidator
        .assign(to: \.isActive, on: proceedButton)
        .store(in: &subscriptions)
    }

    @objc func userDidTapInfoButton(_ sender: UITapGestureRecognizer) {
        delegate?.showDetailViewController(for: .dataAccess)
    }

    @IBAction func userDidChangeAGBSwitch(_ sender: Any) {
        viewModel.didConfirmAGB = agbSwitch.isOn
    }

    @IBAction func userDidChangeScopeSwitch(_ sender: Any) {
        viewModel.didGrantScopes = externalAppAccessSwitch.isOn
    }

    override func userDidTapProceedButton(_ sender: Any) {
        accountCreationViewModel.didConfirmAGB = viewModel.didConfirmAGB
        accountCreationViewModel.didGrantScopes = viewModel.didGrantScopes
        super.userDidTapProceedButton(sender)
    }
}
