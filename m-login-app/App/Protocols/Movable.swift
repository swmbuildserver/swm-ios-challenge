//
//  Movable.swift
//  m-login-app
//
//  Created by Normann Joseph on 30.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

protocol Movable: UIViewController {
    func updateConstraint(_ constraint: NSLayoutConstraint?, newValue: CGFloat, duration: TimeInterval)
}

extension Movable {

    func updateConstraint(_ constraint: NSLayoutConstraint?, newValue: CGFloat, duration: TimeInterval = AnimationDuration.standard) {

        guard let constraint = constraint else { return }

        constraint.constant = newValue
        UIView.animate(withDuration: duration, delay: Delay.none, options: .curveEaseInOut, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        })
    }
}
