//
//  AccountCreationPasswordViewController.swift
//  m-login-app
//
//  Created by Normann Joseph on 24.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

import Combine
class AccountCreationPasswordViewController: AccountCreationBaseViewController {

    @IBOutlet weak var inputField: FloatingLabelInput!
    @IBOutlet weak var lengthConditionLabel: UILabel!
    @IBOutlet weak var complexityConditionLabel: UILabel!
    @IBOutlet weak var complexityLongConditionLabel: UILabel!
    @IBOutlet weak var lengthConditionCheckbox: UIImageView!
    @IBOutlet weak var complexityConditionCheckbox: UIImageView!
    @IBOutlet weak var complexityConditionLongCheckbox: UIImageView!
    @IBOutlet weak var showPasswordImageView: UIImageView!
    @IBOutlet weak var passwordValidCheckbox: UIImageView!

    var viewModel: AccountCreationPasswordViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        accountCreationViewModel.creationStep = .password
        bindViews()
        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        accountCreationViewModel.creationStep = .password
    }

    override func setupViews() {
        super.setupViews()
        inputField.delegate = self
        inputField.labelText = String.localized(key: "PasswordLabel")
        inputField.inputStyle = .password
        inputField.isChecked = false

        lengthConditionLabel.text = String.localized(key: "PasswordConditionLength")
        complexityConditionLabel.text = String.localized(key: "PasswordConditionComplexity")
        complexityLongConditionLabel.text = String.localized(key: "PasswordConditionLongComplexity")

        lengthConditionCheckbox.isHidden = true
        complexityConditionCheckbox.isHidden = true
        complexityConditionLongCheckbox.isHidden = true
    }

    private func bindViews() {

        viewModel.userInputValidator
        .handleEvents(receiveOutput: { [weak self] isValid in
            self?.inputField.isChecked = isValid
        })
        .assign(to: \.isActive, on: proceedButton)
        .store(in: &subscriptions)

        viewModel.lengthConditionValidator
        .assign(to: \.isHidden, on: lengthConditionCheckbox)
        .store(in: &subscriptions)


        viewModel.complexityConditionValidator
        .assign(to: \.isHidden, on: complexityConditionCheckbox)
        .store(in: &subscriptions)


        viewModel.longComplexityConditionValidator
        .assign(to: \.isHidden, on: complexityConditionLongCheckbox)
        .store(in: &subscriptions)
    }

    @IBAction func userDidTapTogglePasswordVisbility(_ sender: Any) {
        print("toggle foggle")
    }

    @IBAction func userDidChangePassword(_ sender: FloatingLabelInput) {
        viewModel.userInput = sender.text ?? ""
    }

    override func userDidTapProceedButton(_ sender: Any) {
        accountCreationViewModel.password = viewModel.userInput
        super.userDidTapProceedButton(sender)
    }
}
