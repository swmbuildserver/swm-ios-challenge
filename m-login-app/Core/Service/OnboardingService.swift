//
//  OnboardingService.swift
//  m-login-app
//
//  Created by Normann Joseph on 28.07.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import Combine
import Foundation

class OnboardingService {

    func checkEmailAvailability(emailAddress: String) -> Just<Bool> {

        return Just(emailAddress).map {
            value -> Bool in {
               
                return emailAddress != "normann@swm.de"
            }()
        }
    }
    
}
