//
//  AbstractViewControllerInstanceFactory.swift
//  m-login-app
//
//  Created by Normann Joseph on 07.04.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

protocol AbstractViewControllerInstanceFactory: AnyObject {
    func makeMainViewController() -> MainViewController
    func makeLobbyNavigationController() -> LobbyNavigationController
}

class ViewControllerInstanceFactory: AbstractViewControllerInstanceFactory {

    func makeMainViewController() -> MainViewController {
        let viewController = UIStoryboard.viewController("MainViewController", storyboard: "Main") as! MainViewController
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }

    func makeLobbyNavigationController() -> LobbyNavigationController {
        let viewController = UIStoryboard.viewController("LobbyNavigationController", storyboard: "Lobby") as! LobbyNavigationController
        return viewController
    }
}
