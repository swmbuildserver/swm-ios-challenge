//
//  DeviceAwareness.swift
//  m-login-app
//
//  Created by Normann Joseph on 01.07.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

protocol DeviceAwareness {
    var isSmallDevice: Bool { get }
}

extension DeviceAwareness {
    var isSmallDevice: Bool {
        let bounds = UIScreen.main.bounds
        //Device Sizes < + Devices are considered as small
        let plusDevicesHeight = CGFloat(736.0)
        return bounds.height < plusDevicesHeight
    }
}
