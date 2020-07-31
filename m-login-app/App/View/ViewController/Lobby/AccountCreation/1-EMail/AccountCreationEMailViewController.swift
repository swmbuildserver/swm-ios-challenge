//
//  AccountCreationEMailViewController.swift
//  m-login-app
//
//  Created by Normann Joseph on 23.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

class AccountCreationEMailViewController: AccountCreationBaseViewController {

    @IBOutlet weak var inputField: FloatingLabelInput!
    
    var viewModel: AccountCreationEMailViewModel!
    var onboardingService: OnboardingService!

    lazy var overlay: CardView = {
        let overlayView = CardView()
        overlayView.cardBackgroundColor = .white
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        return overlayView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        accountCreationViewModel.creationStep = .email
        setupViews()
        bindViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        accountCreationViewModel.creationStep = .email
    }

    override func setupViews() {
        super.setupViews()
        proceedButton.isActive = false
        inputField.delegate = self
        inputField.labelText = viewModel.inputFieldLabelText
    }

    private func bindViews() {

        viewModel.userInputValidator
        .handleEvents(receiveOutput: { [weak self] isValid in
            self?.inputField.isChecked = isValid
        })
        .assign(to: \.isActive, on: proceedButton)
        .store(in: &subscriptions)
    }

    @IBAction func userDidChangeEmailAddress(_ sender: FloatingLabelInput) {
        viewModel.userInput = sender.text ?? ""
    }

    override func userDidTapProceedButton(_ sender: Any) {
        accountCreationViewModel.emailAddress = viewModel.userInput


        addOverlay()
        _ = onboardingService.checkEmailAvailability(emailAddress: viewModel.userInput)
            .sink(
                receiveCompletion: {
                    print("Received completion", $0)
            },
                receiveValue: { result in
                    print("Received value", result)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        #warning("THIS WOULD CAUSE A RETAIN CYCLE -> IT WILL BE REFACTORE AS SOON AS THE REAL BACKEND IS USED HERE!")
                        self.removeOverlay()
                        if result {
                            super.userDidTapProceedButton(sender)
                        } else {
                            //TODO: show alternative Login Screen
                        }
                    }
        })
    }

}

//MARK: Overlay Handling
extension AccountCreationEMailViewController {

    private func addOverlay() {
        overlay.alpha = 0.0
        cardView.addSubview(overlay)

        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        overlay.addSubview(activityIndicatorView)

        NSLayoutConstraint.activate([
            overlay.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            overlay.topAnchor.constraint(equalTo: cardView.topAnchor),
            overlay.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            overlay.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: overlay.centerYAnchor)
        ])
        overlay.setNeedsLayout()
        activityIndicatorView.startAnimating()
        overlay.fadeIn()
    }

    private func removeOverlay() {
        overlay.fadeOut(duration: AnimationDuration.standard, removeFromSuperview: true)
    }
}
