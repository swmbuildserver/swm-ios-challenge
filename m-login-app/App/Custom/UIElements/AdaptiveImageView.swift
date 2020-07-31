//
//  AdaptiveImageView.swift
//  m-login-app
//
//  Created by Normann Joseph on 01.07.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

@IBDesignable
class AdaptiveImageView: UIImageView, DeviceAwareness {

    @IBInspectable
    var fallbackImage: UIImage?

    override func layoutSubviews() {
        super.layoutSubviews()

        if isSmallDevice {
            image = fallbackImage
        }
    }

}
