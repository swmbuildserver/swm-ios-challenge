//
//  ShadowView.swift
//  m-login-app
//
//  Created by Normann Joseph on 06.07.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

@IBDesignable
class ShadowView: UIView {

    public override func prepareForInterfaceBuilder() {
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }

    // MARK: - Inspectable Properties
    @IBInspectable public var topCornerRadius: CGFloat = 10.0

    private func setupView() {
        setupShadows()
    }

    private func setupShadows() {

        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -30)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = topCornerRadius
    }
}
