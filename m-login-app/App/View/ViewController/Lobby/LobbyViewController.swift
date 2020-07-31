//
//  LobbyViewController.swift
//  m-login-app
//
//  Created by Normann Joseph on 08.04.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

protocol LobbyViewControllerDelegate: class {
    func startRegistration()
    func proceedToLogin()
}

class LobbyViewController: UIViewController {

    var viewModel: LobbyViewModel?
    weak var delegate: LobbyViewControllerDelegate?

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var loginButton: RoundedButton!
    @IBOutlet weak var registrationButton: RoundedButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.alpha = Visibility.visible
    }

    private func setupViews() {
        loginButton.title = String.localized(key: "ButtonLogin")
        registrationButton.title = String.localized(key: "ButtonRegister")
    }

    @IBAction func userDidTapLoginButton(_ sender: Any) {
        delegate?.proceedToLogin()
    }

    @IBAction func userDidTapRegistrationButton(_ sender: Any) {
        delegate?.startRegistration()
    }
}
