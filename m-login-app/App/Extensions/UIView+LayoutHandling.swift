//
//  UIView+LayoutHandling.swift
//  m-login-app
//
//  Created by Normann Joseph on 06.07.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

extension UIView {
    func constraintWithIdentifier(_ identifier: String) -> NSLayoutConstraint? {
        return self.constraints.first { $0.identifier == identifier }
    }

    func fadeOut(duration: TimeInterval = AnimationDuration.standard, removeFromSuperview: Bool = false) {
        UIView.animate(withDuration: duration, delay: Delay.none, options: .curveEaseInOut, animations: { [weak self] in
            self?.alpha = Visibility.hidden
        }, completion: { [weak self] _ in
            if removeFromSuperview {
                self?.removeFromSuperview()
            }
        })
    }

    func fadeIn(duration: TimeInterval = AnimationDuration.standard) {
        UIView.animate(withDuration: duration, delay: Delay.none, options: .curveEaseInOut, animations: { [weak self] in
            self?.alpha = Visibility.visible
        })
    }

}
