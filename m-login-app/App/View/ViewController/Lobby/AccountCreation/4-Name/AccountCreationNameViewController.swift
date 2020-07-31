//
//  AccountCreationNameViewController.swift
//  m-login-app
//
//  Created by Normann Joseph on 26.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

class AccountCreationNameViewController: AccountCreationBaseViewController {

    @IBOutlet weak var firstNameTextField: FloatingLabelInput!
    @IBOutlet weak var lastNameTextField: FloatingLabelInput!

    var viewModel: AccountCreationNameViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        accountCreationViewModel.creationStep = .name
        bindViews()
        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        accountCreationViewModel.creationStep = .name
    }

    override func setupViews() {
        super.setupViews()
        firstNameTextField.delegate = self
        firstNameTextField.labelText = viewModel.firstNameLabelText
        lastNameTextField.delegate = self
        lastNameTextField.labelText = viewModel.lastNameLabelText
    }

    private func bindViews() {

        viewModel.firstnameValidator
        .handleEvents(receiveOutput: { [weak self] isValid in
            self?.firstNameTextField.isChecked = isValid
        })
        .map { [weak self] isValid in
            guard let strongSelf = self else { return false }
            return isValid && strongSelf.lastNameTextField.isChecked
        }
        .assign(to: \.isActive, on: proceedButton)
        .store(in: &subscriptions)

        viewModel.lastnameValidator
        .handleEvents(receiveOutput: { [weak self] isValid in
            self?.lastNameTextField.isChecked = isValid
        })
        .map { [weak self] isValid in
            guard let strongSelf = self else { return false }
            return isValid && strongSelf.firstNameTextField.isChecked
        }
        .assign(to: \.isActive, on: proceedButton)
        .store(in: &subscriptions)
    }

    @IBAction func userDidChangeFirstName(_ sender: FloatingLabelInput) {
        viewModel.firstName = sender.text ?? ""
    }

    @IBAction func userDidChangeLastName(_ sender: FloatingLabelInput) {
        viewModel.lastName = sender.text ?? ""
    }

    override func userDidTapProceedButton(_ sender: Any) {
        accountCreationViewModel.firstName = viewModel.firstName
        accountCreationViewModel.lastName = viewModel.lastName
        super.userDidTapProceedButton(sender)
    }
}
