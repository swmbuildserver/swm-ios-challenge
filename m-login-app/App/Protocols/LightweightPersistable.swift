//
//  LightweightPersistable.swift
//  m-login-app
//
//  Created by Normann Joseph on 01.07.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

protocol LightweightPersistable: UIViewController {
    var keyboardHeight: CGFloat { get set }
}

extension UIViewController {
    fileprivate enum PersistableKeys: String {
        case keyboardHeight
    }
}

extension LightweightPersistable {

    var keyboardHeight: CGFloat {
        get {
            return CGFloat(UserDefaults.standard.float(forKey: PersistableKeys.keyboardHeight.rawValue))
        }
        set (newValue) {
            UserDefaults.standard.set(newValue, forKey: PersistableKeys.keyboardHeight.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
