//
//  AccountCreationCountryViewController.swift
//  m-login-app
//
//  Created by Normann Joseph on 26.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

class AccountCreationCountryViewController: AccountCreationBaseViewController {

    @IBOutlet weak var countryTextField: FloatingLabelInput!
    let countryPicker = UIPickerView()
    @IBOutlet weak var skipButton: UIButton!

    var viewModel: AccountCreationCountryViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        accountCreationViewModel.creationStep = .country
        bindViews()
        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        accountCreationViewModel.creationStep = .country
    }

    override func setupViews() {
        super.setupViews()
        setupCountryPicker()
        countryTextField.labelText = viewModel.countryTextFieldLabelText
        countryTextField.addTarget(self, action: #selector(userDidStartCountrySelection), for: .editingDidBegin)
        countryTextField.inputView = countryPicker
        skipButton.setTitle(viewModel.skipButtonText, for: .normal)
    }

    private func setupCountryPicker() {
        countryPicker.delegate = self
        countryPicker.selectRow(viewModel.currentCountryIsocodeIndex, inComponent: 0, animated: false)
    }

    @objc func userDidStartCountrySelection() {
        if let text = countryTextField.text, text.isEmpty {
            viewModel.selectedCountry = viewModel.country(at: countryPicker.selectedRow(inComponent: 0))
        }
    }

    private func bindViews() {

        viewModel.countryValidator
        .handleEvents(receiveOutput: { [weak self] isValid in
            guard let strongSelf = self else { return }
            strongSelf.countryTextField.isChecked = isValid
            strongSelf.countryTextField.text = strongSelf.viewModel.selectedCountry
        })
        .assign(to: \.isActive, on: proceedButton)
        .store(in: &subscriptions)
    }

    override func userDidTapProceedButton(_ sender: Any) {
        accountCreationViewModel.country = viewModel.selectedCountry
        accountCreationViewModel.userRegion = viewModel.currentLocaleIsoCode
        super.userDidTapProceedButton(sender)
    }

    @IBAction func userDidTapSkipButton(_ sender: Any) {
        delegate?.skip(viewModel: accountCreationViewModel)
    }

}

extension AccountCreationCountryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.numberOfCountries
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.country(at: row)
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.selectedCountry = viewModel.country(at: row)
    }
}
