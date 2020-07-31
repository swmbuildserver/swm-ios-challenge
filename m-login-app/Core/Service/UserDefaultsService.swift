//
//  UserDefaultsService.swift
//  m-login-app
//
//  Created by Normann Joseph on 08.04.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import Foundation

class UserDefaultsService {

    private struct Constants {
        static let isUserLoggedIn = "isUserLoggedIn"
    }

    static let shared = UserDefaultsService()

    var isUserLoggedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Constants.isUserLoggedIn)
        }
        set (newValue){
            UserDefaults.standard.set(newValue, forKey: Constants.isUserLoggedIn)
            UserDefaults.standard.synchronize()
        }
    }

}
