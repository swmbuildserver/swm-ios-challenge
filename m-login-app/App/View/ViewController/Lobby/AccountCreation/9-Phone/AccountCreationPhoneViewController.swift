//
//  AccountCreationPhoneViewController.swift
//  m-login-app
//
//  Created by Normann Joseph on 26.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

class AccountCreationPhoneViewController: AccountCreationBaseViewController {

    @IBOutlet weak var inputField: FloatingLabelInput!

    var viewModel: AccountCreationPhoneViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        accountCreationViewModel.creationStep = .phone
        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        accountCreationViewModel.creationStep = .phone
    }
    
    override func setupViews() {
        super.setupViews()
        inputField.delegate = self
        inputField.labelText = viewModel.phoneNumberLabelText
    }

    @IBAction func phoneNumberChanged(_ sender: Any) {
        inputField.text = inputField.text?.formatPhoneNumber()
        viewModel.mobileNumber = inputField.text
    }

    override func userDidTapProceedButton(_ sender: Any) {
        accountCreationViewModel.mobileNumber = viewModel.mobileNumber
        super.userDidTapProceedButton(sender)
    }


}

