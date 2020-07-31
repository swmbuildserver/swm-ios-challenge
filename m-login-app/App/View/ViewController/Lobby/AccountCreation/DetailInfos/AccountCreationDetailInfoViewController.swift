//
//  AccountCreationDetailInfoViewController.swift
//  m-login-app
//
//  Created by Normann Joseph on 29.07.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

class AccountCreationDetailInfoViewController: UIViewController {

    var viewModel: AccountCreationDetailInfoViewModel!
    @IBOutlet weak var contentStackView: UIStackView!

    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        for item in viewModel.dummyContent {
            let label = UILabel()
            label.text = item
            label.numberOfLines = 0
            contentStackView.insertArrangedSubview(label, at: contentStackView.arrangedSubviews.count)
        }
    }

    @IBAction func userDidTapDismissButton(_ sender: Any) {
        dismiss(animated: true)
    }
}
