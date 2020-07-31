//
//  UIStoryboard+ViewController.swift
//  m-login-app
//
//  Created by Normann Joseph on 07.04.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

extension UIStoryboard {

    static func viewController(_ name: String, storyboard: String) -> UIViewController {
        return UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: name)
    }

}
