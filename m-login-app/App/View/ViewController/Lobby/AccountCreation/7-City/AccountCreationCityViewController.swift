//
//  AccountCreationCityViewController.swift
//  m-login-app
//
//  Created by Normann Joseph on 26.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

class AccountCreationCityViewController: AccountCreationBaseViewController {

    @IBOutlet weak var zipCodeTextField: FloatingLabelInput!
    @IBOutlet weak var cityTextField: FloatingLabelInput!

    var viewModel: AccountCreationCityViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        accountCreationViewModel.creationStep = .city
        viewModel.userRegion = accountCreationViewModel.userRegion
        bindViews()
        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        accountCreationViewModel.creationStep = .city
    }

    override func setupViews() {
        super.setupViews()
        cityTextField.delegate = self
        cityTextField.labelText = viewModel.cityTextFieldText
        zipCodeTextField.delegate = self
        zipCodeTextField.labelText = viewModel.zipCodeTextFieldText
    }

    private func bindViews() {

        viewModel.zipCodeValidator
            .handleEvents(receiveOutput: { [weak self] isValid in
                self?.zipCodeTextField.isChecked = isValid
            })
            .map { [weak self] isValid in
                guard let strongSelf = self else { return false }
                return isValid && strongSelf.cityTextField.isChecked
        }
        .assign(to: \.isActive, on: proceedButton)
        .store(in: &subscriptions)

        viewModel.cityValidator
            .handleEvents(receiveOutput: { [weak self] isValid in
                self?.cityTextField.isChecked = isValid
            })
            .map { [weak self] isValid in
                guard let strongSelf = self else { return false }
                return isValid && strongSelf.zipCodeTextField.isChecked
        }
        .assign(to: \.isActive, on: proceedButton)
        .store(in: &subscriptions)
    }

    @IBAction func userDidChangeZipCode(_ sender: FloatingLabelInput) {
        viewModel.zipCode = sender.text ?? ""
    }

    @IBAction func userDidChangeCity(_ sender: FloatingLabelInput) {
        viewModel.city = sender.text ?? ""
    }


    override func userDidTapProceedButton(_ sender: Any) {
        accountCreationViewModel.zipCode = viewModel.zipCode
        accountCreationViewModel.city = viewModel.city
        super.userDidTapProceedButton(sender)
    }
}
