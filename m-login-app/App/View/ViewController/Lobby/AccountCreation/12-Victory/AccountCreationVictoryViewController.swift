//
//  AccountCreationVictoryViewController.swift
//  m-login-app
//
//  Created by Normann Joseph on 26.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

class AccountCreationVictoryViewController: AccountCreationBaseViewController {

    private struct Constants {
        static let defaultGoodieSize: CGFloat = 186.0
        static let smallGoodieSize: CGFloat = 124.0
        static let goodieDefaultTopSpace: CGFloat = 88.0
        static let goodieSmallTopSpace: CGFloat = 24.0
    }


    @IBOutlet weak var headlineBottomLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!

    @IBOutlet weak var goodieTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var goodieWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var goodieHeightConstraint: NSLayoutConstraint!

    var viewModel: AccountCreationVictoryViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        accountCreationViewModel.creationStep = .victory
        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        accountCreationViewModel.creationStep = .victory
    }

    override func setupViews() {
        super.setupViews()
        headlineLabel.text = String.localized(key: "VictoryHeadlineTop")
        headlineBottomLabel.text = String.localized(key: "VictoryHeadlineBottom")
        detailsLabel.text = String.localized(key: "VictoryText")
        proceedButton.titleLabel.text = String.localized(key: "VictoryProceed")

        headlineBottomLabel.font = isSmallDevice ? UIFont.h1SfProDisplayDarkSmall : UIFont.h1SfProDisplayDark

        goodieWidthConstraint.constant = isSmallDevice ? Constants.smallGoodieSize : Constants.defaultGoodieSize
        goodieHeightConstraint.constant = isSmallDevice ? Constants.smallGoodieSize : Constants.defaultGoodieSize
        goodieTopConstraint.constant = isSmallDevice ? Constants.goodieSmallTopSpace : Constants.goodieDefaultTopSpace
    }

}
