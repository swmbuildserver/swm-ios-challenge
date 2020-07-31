//
//  ApplicationCoordinator.swift
//  m-login-app
//
//  Created by Normann Joseph on 07.04.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

class ApplicationCoordinator: Coordinator {

    let window: UIWindow

    let coordinator: Coordinator?

    init(window: UIWindow, viewControllerInstanceFactory: AbstractViewControllerInstanceFactory) {
        self.window = window
        // TODO: Check here later, if the user is logged in or not. Then present the LobbyViewController for registration/login, or jump directly into
        // MainViewController

        // Simulated via User Defaults for early Dev State
        MLoginCore.shared.userService.isUserLoggedIn = false

        // Logged in users will be immediatly use the app, while
        // Not Logged in users MUST login or signup
        coordinator = MLoginCore.shared.userService.isUserLoggedIn ?
            MainCoordinator(window: window, viewControllerInstanceFactory: viewControllerInstanceFactory) :
            LobbyCoordinator(window: window, viewControllerInstanceFactory: viewControllerInstanceFactory)
    }

    func start() {

        guard let coordinator = coordinator else {
            return
        }
        coordinator.start()
        
        window.makeKeyAndVisible()
    }
}
