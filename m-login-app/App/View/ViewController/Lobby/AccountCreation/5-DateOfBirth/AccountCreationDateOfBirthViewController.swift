//
//  AccountCreationDateOfBirthViewController.swift
//  m-login-app
//
//  Created by Normann Joseph on 26.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

class AccountCreationDateOfBirthViewController: AccountCreationBaseViewController {

    @IBOutlet weak var dateOfBirthTextField: FloatingLabelInput!

    private let datePicker = UIDatePicker()

    var viewModel: AccountCreationDateOfBirthViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        accountCreationViewModel.creationStep = .dateOfBirth
        bindViews()
        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        accountCreationViewModel.creationStep = .dateOfBirth
    }

    override func setupViews() {
        super.setupViews()
        dateOfBirthTextField.labelText = viewModel.dateOfBirthLabelText
        setupDatePicker()
    }

    private func setupDatePicker() {
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.addTarget(self, action: #selector(userSelectedDate), for: .valueChanged)

        let now = Date()
        datePicker.maximumDate = now
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: now)
        datePicker.setDate(Calendar.current.date(byAdding: .year, value: -30, to: now) ?? now, animated: false)

        dateOfBirthTextField.addTarget(self, action: #selector(userDidStartDateSelection), for: .editingDidBegin)
        dateOfBirthTextField.addTarget(self, action: #selector(userDidEndDateSelection), for: .editingDidEnd)
        dateOfBirthTextField.inputView = datePicker
    }

    private func bindViews() {

        viewModel.dateOfBirthValidator
        .handleEvents(receiveOutput: { [weak self] isValid in
            guard let strongSelf = self else { return }
            strongSelf.dateOfBirthTextField.isChecked = isValid
            strongSelf.dateOfBirthTextField.text = strongSelf.viewModel.userSelectedDate
        })
        .assign(to: \.isActive, on: proceedButton)
        .store(in: &subscriptions)
    }




    @objc func userSelectedDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = viewModel.displayDateFormat
        viewModel.userSelectedDate = dateFormatter.string(from: datePicker.date)
    }

    @objc func userDidStartDateSelection() {

        if let text = dateOfBirthTextField.text, text.isEmpty {
            dateOfBirthTextField.text = viewModel.dateOfBirthPlaceholderText
        }
    }

    @objc func userDidEndDateSelection() {
        //todo: make label float back down if input is empty
    }

    override func userDidTapProceedButton(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = viewModel.iso8601Format
        accountCreationViewModel.dateOfBirth = dateFormatter.string(from: datePicker.date)
        super.userDidTapProceedButton(sender)
    }

}
