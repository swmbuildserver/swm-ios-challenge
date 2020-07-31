//
//  ProgressBarView.swift
//  m-login-app
//
//  Created by Normann Joseph on 23.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

@IBDesignable
class ProgressBarView: UIView {

    private var progressIndicator: UIView!
    public var percentage: CGFloat = 0.0 {
        didSet {
            progressIndicator = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width * percentage, height: frame.size.height))
        }
    }

    public override func prepareForInterfaceBuilder() {
        setupView()
    }

    private func setupView() {
        setupProgressBarBackground()
        setupProgressIndicator()
    }

    override func layoutSubviews() {
        setupView()
    }

    private func setupProgressBarBackground() {
        backgroundColor = .lightGrey
        layer.cornerRadius = 5
        clipsToBounds = true

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.ice.cgColor, UIColor.paleMauve.cgColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.shouldRasterize = false

        layer.addSublayer(gradientLayer)
    }

    func setupProgressIndicator() {

        progressIndicator = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width * percentage, height: frame.size.height))
        progressIndicator.layer.cornerRadius = 5
        progressIndicator.clipsToBounds = true

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = progressIndicator.bounds
        gradientLayer.colors = [UIColor.brightBlue.cgColor, UIColor.duskBlue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.shouldRasterize = false
        progressIndicator.layer.addSublayer(gradientLayer)
        insertSubview(progressIndicator, aboveSubview: self)
    }
}
