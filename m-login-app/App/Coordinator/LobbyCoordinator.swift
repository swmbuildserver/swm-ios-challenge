//
//  LobbyCoordinator.swift
//  m-login-app
//
//  Created by Normann Joseph on 08.04.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import Foundation

import UIKit

class LobbyCoordinator: Coordinator {

    let window: UIWindow?
    private var viewController: LobbyNavigationController!
    private var rootViewController: LobbyViewController!

    var viewControllerInstanceFactory: AbstractViewControllerInstanceFactory!

    //No dependency injection yet, to avoid instanciation when not needed, i.e. if the user does not register, we do not need the factory
    //check if this approach is feasible
    lazy var onboardingViewControllerInstanceFactory = OnboardingViewControllerInstanceFactory()

    init(window: UIWindow, viewControllerInstanceFactory: AbstractViewControllerInstanceFactory) {
        self.window = window
        self.viewControllerInstanceFactory = viewControllerInstanceFactory
    }

    func start() {
        viewController = viewControllerInstanceFactory.makeLobbyNavigationController()
        rootViewController = viewController.viewControllers.first as? LobbyViewController
        rootViewController.delegate = self

        window?.rootViewController = viewController

        //DEV VALUE
//        startRegistration()
    }


    deinit { print("\(String(describing: self)) is being deinitialized") }

}

extension LobbyCoordinator: LobbyViewControllerDelegate {

    func startRegistration() {
        let viewModel = AccountCreationViewModel(accountCreationContext: .externalAppRequirement)
        let viewController = onboardingViewControllerInstanceFactory.makeAccountCreationEMailViewController(viewModel: viewModel)
        viewController.delegate = self
        rootViewController.show(viewController, sender: viewController)

        //DEV PURPOSE - REMOVE AT THE END OF ONBOARDING
//        viewModel.creationStep = .email
//        proceed(viewModel: viewModel)
    }

    func proceedToLogin() {
        print("Login all day long!")
    }


}

extension LobbyCoordinator: AccountCreationFlowDelegate {

    func proceed(viewModel: AccountCreationViewModel) {
        var viewController: AccountCreationBaseViewController? = nil
        switch viewModel.creationStep {
        case .email:
            viewController = onboardingViewControllerInstanceFactory.makeAccountCreationPasswordViewController(viewModel: viewModel)
        case .password:
            viewController = onboardingViewControllerInstanceFactory.makeAccountCreationSalutationViewController(viewModel: viewModel)
        case .salutation:
            viewController = onboardingViewControllerInstanceFactory.makeAccountCreationNameViewController(viewModel: viewModel)
        case .name:
            viewController = onboardingViewControllerInstanceFactory.makeAccountCreationDateOfBirthViewController(viewModel: viewModel)
        case .dateOfBirth:
            viewController = onboardingViewControllerInstanceFactory.makeAccountCreationCountryViewController(viewModel: viewModel)
        case .country:
            viewController = onboardingViewControllerInstanceFactory.makeAccountCreationCityViewController(viewModel: viewModel)
        case .city:
            viewController = onboardingViewControllerInstanceFactory.makeAccountCreationAddressViewController(viewModel: viewModel)
        case .address:
            viewController = onboardingViewControllerInstanceFactory.makeAccountCreationPhoneViewController(viewModel: viewModel)
        case .phone:
            viewController = onboardingViewControllerInstanceFactory.makeAccountCreationLegalViewController(viewModel: viewModel)
        case .legal:
            viewController = onboardingViewControllerInstanceFactory.makeAccountCreationOptinViewController(viewModel: viewModel)
        case .optin:
            viewController = onboardingViewControllerInstanceFactory.makeAccountCreationVictoryViewController(viewModel: viewModel)
        case .victory:
            rootViewController.navigationController?.popToRootViewController(animated: true)
        }
        if let viewController = viewController {
            viewController.delegate = self
            rootViewController.show(viewController, sender: viewController)
        }
    }

    /**
     Show detail ViewControllers in modal transitions
     */
    func showDetailViewController(for context: AccountCreationOverlayDetailContext) {
        let viewController = onboardingViewControllerInstanceFactory.makeDetailViewController(for: context)
        rootViewController.present(viewController, animated: true)
    }

    /**
     Currently we have 2 entry points during the onboarding, where a user is asked to skip onboarding. therefore the following implementations handles only .salutation and .country
     as entry points to skip onboarding.
     in these cases the viewcontrollerstack is just created for a complete onboarding flow, to enable a consistent back navigation
     */
    func skip(viewModel: AccountCreationViewModel) {
        guard let navigationController = rootViewController.navigationController else { return }

        if viewModel.creationStep == .salutation {

            append(viewController: onboardingViewControllerInstanceFactory.makeAccountCreationNameViewController(viewModel: viewModel), to: navigationController)
            append(viewController: onboardingViewControllerInstanceFactory.makeAccountCreationDateOfBirthViewController(viewModel: viewModel), to: navigationController)
            append(viewController: onboardingViewControllerInstanceFactory.makeAccountCreationCountryViewController(viewModel: viewModel), to: navigationController)

        }

        append(viewController: onboardingViewControllerInstanceFactory.makeAccountCreationCityViewController(viewModel: viewModel), to: navigationController)
        append(viewController: onboardingViewControllerInstanceFactory.makeAccountCreationAddressViewController(viewModel: viewModel), to: navigationController)
        append(viewController: onboardingViewControllerInstanceFactory.makeAccountCreationPhoneViewController(viewModel: viewModel), to: navigationController)

        // now  we are ready to show the target viewcontroller
        let legalViewController = onboardingViewControllerInstanceFactory.makeAccountCreationLegalViewController(viewModel: viewModel)
        legalViewController.delegate = self
        rootViewController.show(legalViewController, sender: legalViewController)
    }

    private func append(viewController: AccountCreationBaseViewController, to navigationController: UINavigationController) {
        viewController.delegate = self
        navigationController.viewControllers.append(viewController)
    }
}
