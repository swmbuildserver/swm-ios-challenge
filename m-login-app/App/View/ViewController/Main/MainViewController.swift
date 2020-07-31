//
//  MainViewController.swift
//  m-login-app
//
//  Created by Normann Joseph on 06.04.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

//TODO: MainViewController will be the containerViewController for the App. Most certain it will be a tabBarViewController
class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
    }

    private func setupTabbar() {
        selectedIndex = 0
    }

}

