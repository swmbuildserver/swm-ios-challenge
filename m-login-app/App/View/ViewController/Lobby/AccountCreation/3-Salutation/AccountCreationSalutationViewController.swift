//
//  AccountCreationSalutationViewController.swift
//  m-login-app
//
//  Created by Normann Joseph on 26.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

class AccountCreationSalutationViewController: AccountCreationBaseViewController {

    @IBOutlet weak var salutationTextField: FloatingLabelInput!
    @IBOutlet weak var titleTextField: FloatingLabelInput!
    @IBOutlet weak var skipButton: UIButton!


    var viewModel: AccountCreationSalutationViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        accountCreationViewModel.creationStep = .salutation
        setupViews()
        bindViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        accountCreationViewModel.creationStep = .salutation
    }

    override func setupViews() {
        super.setupViews()
        salutationTextField.labelText = viewModel.salutationLabelText
        let salutationPicker = UIPickerView()
        salutationPicker.delegate = self
        salutationTextField.inputView = salutationPicker
        salutationPicker.selectRow(0, inComponent: 0, animated: false)
        titleTextField.delegate = self
        titleTextField.labelText = viewModel.salutationTitleLabelText
        skipButton.setTitle(viewModel.skipButtonText, for: .normal)
        
    }

    private func bindViews() {

        viewModel.salutationValidator
        .handleEvents(receiveOutput: { [weak self] isValid in
            self?.salutationTextField.isChecked = isValid
            self?.salutationTextField.text = self?.viewModel.selectedSalutation
        })
        .assign(to: \.isActive, on: proceedButton)
        .store(in: &subscriptions)
    }

    override func keyboardWillShow(notification: NSNotification) {
        super.keyboardWillShow(notification: notification)
        if viewModel.selectedSalutation == nil {
            viewModel.salutationOptionSelected(at: 0)
        }
    }

    override func userDidTapProceedButton(_ sender: Any) {
        accountCreationViewModel.salutation = viewModel.selectedSalutatuionValue
        accountCreationViewModel.salutationTitle = titleTextField.text
        super.userDidTapProceedButton(sender)
    }

    @IBAction func userDidTapSkipButton(_ sender: Any) {
        delegate?.skip(viewModel: accountCreationViewModel)
    }

}

extension AccountCreationSalutationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.numberOfSalutationOptions
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.salutationOption(at: row)
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.salutationOptionSelected(at: row)
    }

}
