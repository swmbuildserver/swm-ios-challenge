//
//  OnboardingViewControllerInstanceFactory.swift
//  m-login-app
//
//  Created by Normann Joseph on 07.07.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

protocol AbstractOnboardingViewControllerInstanceFactory: AnyObject {
    func makeAccountCreationEMailViewController(viewModel: AccountCreationViewModel) -> AccountCreationEMailViewController
    func makeAccountCreationPasswordViewController(viewModel: AccountCreationViewModel) -> AccountCreationPasswordViewController
    func makeAccountCreationSalutationViewController(viewModel: AccountCreationViewModel) -> AccountCreationSalutationViewController

    func makeAccountCreationNameViewController(viewModel: AccountCreationViewModel) -> AccountCreationNameViewController
    func makeAccountCreationDateOfBirthViewController(viewModel: AccountCreationViewModel) -> AccountCreationDateOfBirthViewController
    func makeAccountCreationCountryViewController(viewModel: AccountCreationViewModel) -> AccountCreationCountryViewController

    func makeAccountCreationCityViewController(viewModel: AccountCreationViewModel) -> AccountCreationCityViewController
    func makeAccountCreationAddressViewController(viewModel: AccountCreationViewModel) -> AccountCreationAddressViewController
    func makeAccountCreationPhoneViewController(viewModel: AccountCreationViewModel) -> AccountCreationPhoneViewController

    func makeAccountCreationLegalViewController(viewModel: AccountCreationViewModel) -> AccountCreationLegalViewController
    func makeAccountCreationOptinViewController(viewModel: AccountCreationViewModel) -> AccountCreationOptinViewController
    func makeAccountCreationVictoryViewController(viewModel: AccountCreationViewModel) -> AccountCreationVictoryViewController

    func makeDetailViewController(for context: AccountCreationOverlayDetailContext) -> AccountCreationDetailInfoViewController
}

class OnboardingViewControllerInstanceFactory: AbstractOnboardingViewControllerInstanceFactory {

    func makeAccountCreationEMailViewController(viewModel: AccountCreationViewModel) -> AccountCreationEMailViewController {
        let viewController = UIStoryboard.viewController("AccountCreationEMailViewController", storyboard: "Lobby") as! AccountCreationEMailViewController
        viewController.accountCreationViewModel = viewModel
        viewController.viewModel = AccountCreationEMailViewModel()

        //todo: somtime later a config will be required - for dev purpose this is now ok
        viewController.onboardingService = OnboardingService()
        return viewController
    }

    func makeAccountCreationPasswordViewController(viewModel: AccountCreationViewModel) -> AccountCreationPasswordViewController {
        let viewController = UIStoryboard.viewController("AccountCreationPasswordViewController", storyboard: "Lobby") as! AccountCreationPasswordViewController
        viewController.accountCreationViewModel = viewModel
        viewController.viewModel = AccountCreationPasswordViewModel()
        return viewController
    }

    func makeAccountCreationSalutationViewController(viewModel: AccountCreationViewModel) -> AccountCreationSalutationViewController {
        let viewController = UIStoryboard.viewController("AccountCreationSalutationViewController", storyboard: "Lobby") as! AccountCreationSalutationViewController
        viewController.accountCreationViewModel = viewModel
        viewController.viewModel = AccountCreationSalutationViewModel()
        return viewController
    }

    func makeAccountCreationNameViewController(viewModel: AccountCreationViewModel) -> AccountCreationNameViewController {
        let viewController = UIStoryboard.viewController("AccountCreationNameViewController", storyboard: "Lobby") as! AccountCreationNameViewController
        viewController.accountCreationViewModel = viewModel
        viewController.viewModel = AccountCreationNameViewModel()
        return viewController
    }

    func makeAccountCreationDateOfBirthViewController(viewModel: AccountCreationViewModel) -> AccountCreationDateOfBirthViewController {
        let viewController = UIStoryboard.viewController("AccountCreationDateOfBirthViewController", storyboard: "Lobby") as! AccountCreationDateOfBirthViewController
        viewController.accountCreationViewModel = viewModel
        viewController.viewModel = AccountCreationDateOfBirthViewModel()
        return viewController
    }

    func makeAccountCreationCountryViewController(viewModel: AccountCreationViewModel) -> AccountCreationCountryViewController {
        let viewController = UIStoryboard.viewController("AccountCreationCountryViewController", storyboard: "Lobby") as! AccountCreationCountryViewController
        viewController.accountCreationViewModel = viewModel
        viewController.viewModel = AccountCreationCountryViewModel()
        return viewController
    }

    func makeAccountCreationCityViewController(viewModel: AccountCreationViewModel) -> AccountCreationCityViewController {
        let viewController = UIStoryboard.viewController("AccountCreationCityViewController", storyboard: "Lobby") as! AccountCreationCityViewController
        viewController.accountCreationViewModel = viewModel
        viewController.viewModel = AccountCreationCityViewModel()
        return viewController
    }

    func makeAccountCreationAddressViewController(viewModel: AccountCreationViewModel) -> AccountCreationAddressViewController {
        let viewController = UIStoryboard.viewController("AccountCreationAddressViewController", storyboard: "Lobby") as! AccountCreationAddressViewController
        viewController.accountCreationViewModel = viewModel
        viewController.viewModel = AccountCreationAddressViewModel()
        return viewController
    }

    func makeAccountCreationPhoneViewController(viewModel: AccountCreationViewModel) -> AccountCreationPhoneViewController {
        let viewController = UIStoryboard.viewController("AccountCreationPhoneViewController", storyboard: "Lobby") as! AccountCreationPhoneViewController
        viewController.accountCreationViewModel = viewModel
        viewController.viewModel = AccountCreationPhoneViewModel()
        return viewController
    }

    func makeAccountCreationLegalViewController(viewModel: AccountCreationViewModel) -> AccountCreationLegalViewController {
        let viewController = UIStoryboard.viewController("AccountCreationLegalViewController", storyboard: "Lobby") as! AccountCreationLegalViewController
        viewController.accountCreationViewModel = viewModel
        viewController.viewModel = AccountCreationLegalViewModel(accountCreationContext: viewModel.accountCreationContext)
        return viewController
    }

    func makeAccountCreationOptinViewController(viewModel: AccountCreationViewModel) -> AccountCreationOptinViewController {
        let viewController = UIStoryboard.viewController("AccountCreationOptinViewController", storyboard: "Lobby") as! AccountCreationOptinViewController
        viewController.accountCreationViewModel = viewModel
        viewController.viewModel = AccountCreationOptinViewModel()
        return viewController
    }

    func makeAccountCreationVictoryViewController(viewModel: AccountCreationViewModel) -> AccountCreationVictoryViewController {
        let viewController = UIStoryboard.viewController("AccountCreationVictoryViewController", storyboard: "Lobby") as! AccountCreationVictoryViewController
        viewController.accountCreationViewModel = viewModel
        viewController.viewModel = AccountCreationVictoryViewModel()
        return viewController
    }
    
    func makeDetailViewController(for context: AccountCreationOverlayDetailContext) -> AccountCreationDetailInfoViewController {
        let viewController = UIStoryboard.viewController("AccountCreationDetailInfoViewController", storyboard: "AccountCreationDetailInfoViewController") as! AccountCreationDetailInfoViewController
        viewController.viewModel = AccountCreationDetailInfoViewModel(context: context)
        return viewController
    }

}
