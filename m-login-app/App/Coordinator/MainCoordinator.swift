//
//  MainCoordinator.swift
//  m-login-app
//
//  Created by Normann Joseph on 07.04.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {

    let window: UIWindow?
    private var mainViewController: MainViewController!

    var viewControllerInstanceFactory: AbstractViewControllerInstanceFactory!

    init(window: UIWindow, viewControllerInstanceFactory: AbstractViewControllerInstanceFactory) {
        self.window = window
        self.viewControllerInstanceFactory = viewControllerInstanceFactory
    }

    func start() {
        let mainViewController = viewControllerInstanceFactory.makeMainViewController()

        //JUST A PLACEHOLDER
        let someViewController = viewControllerInstanceFactory.makeLobbyNavigationController()
        someViewController.tabBarItem.title = "Some"
        mainViewController.addChild(someViewController)

        window?.rootViewController = mainViewController
    }

}
