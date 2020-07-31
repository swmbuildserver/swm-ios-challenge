//
//  AccountCreationAddressViewController.swift
//  m-login-app
//
//  Created by Normann Joseph on 26.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

class AccountCreationAddressViewController: AccountCreationBaseViewController {

    @IBOutlet weak var streetTextField: FloatingLabelInput!
    @IBOutlet weak var numberTextField: FloatingLabelInput!
    @IBOutlet weak var additionalTextField: FloatingLabelInput!

    var viewModel: AccountCreationAddressViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        accountCreationViewModel.creationStep = .address
        bindViews()
        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        accountCreationViewModel.creationStep = .address
    }

    override func setupViews() {
        super.setupViews()
        streetTextField.delegate = self
        streetTextField.labelText = viewModel.streetTextFieldLabelText
        numberTextField.delegate = self
        numberTextField.labelText = viewModel.numberTextFieldLabelText
        additionalTextField.delegate = self
        additionalTextField.labelText = viewModel.additionalTextFieldLabelText
    }

    private func bindViews() {

        viewModel.streetValidator
            .handleEvents(receiveOutput: { [weak self] isValid in
                self?.streetTextField.isChecked = isValid
            })
            .map { [weak self] isValid in
                guard let strongSelf = self else { return false }
                return isValid && strongSelf.numberTextField.isChecked
        }
        .assign(to: \.isActive, on: proceedButton)
        .store(in: &subscriptions)

        viewModel.streetNumberValidator
            .handleEvents(receiveOutput: { [weak self] isValid in
                self?.numberTextField.isChecked = isValid
            })
            .map { [weak self] isValid in
                guard let strongSelf = self else { return false }
                return isValid && strongSelf.streetTextField.isChecked
        }
        .assign(to: \.isActive, on: proceedButton)
        .store(in: &subscriptions)
    }

    @IBAction func userDidChangeStreet(_ sender: FloatingLabelInput) {
        viewModel.street = sender.text ?? ""
    }

    @IBAction func userDidChangeStreetNumber(_ sender: FloatingLabelInput) {
        viewModel.streetNumber = sender.text ?? ""
    }

    @IBAction func userDidChangeAdditionalAddress(_ sender: FloatingLabelInput) {
        viewModel.additionalAddress = sender.text ?? ""
    }


    override func userDidTapProceedButton(_ sender: Any) {
        accountCreationViewModel.street = viewModel.street
        accountCreationViewModel.streetNumber = viewModel.streetNumber
        accountCreationViewModel.additionalAddress = viewModel.additionalAddress
        super.userDidTapProceedButton(sender)
    }
    
}
