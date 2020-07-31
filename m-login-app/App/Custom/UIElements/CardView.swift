//
//  CardView.swift
//  m-login-app
//
//  Created by Normann Joseph on 23.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

@IBDesignable
class CardView: UIView {

    var cardBackgroundColor: UIColor = .white

    private let cardView = UIView(frame: .zero)


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
        backgroundColor = .clear
        addCardView()
    }

    private func addCardView() {
        cardView.backgroundColor = cardBackgroundColor
        cardView.roundCorners(corners:[.topLeft, .topRight] , radius: 20.0)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(cardView, at: 0)
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

    }

}

extension UIView {

   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath

        layer.mask = mask
    }
}
