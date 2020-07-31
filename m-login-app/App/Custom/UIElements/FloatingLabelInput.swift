//
//  FloatingLabelInput.swift
//  m-login-app
//
//  Created by Normann Joseph on 30.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

class FloatingLabelInput: UITextField {

    enum InputStyle {
        case text, password
    }

    private struct Constants {
        static let bottomSpaceIntitial: CGFloat = 8.0
        static let bottomSpaceFloating: CGFloat = 40.0
    }

    public var value: String {
        return text ?? ""
    }

    var inputStyle: InputStyle = .text {
        didSet {
            switch inputStyle {
            case .password:
                isSecureTextEntry = true
            default:
                isSecureTextEntry = false
            }
        }
    }

    var isChecked: Bool = false {
        didSet {
            if isChecked {
                //animate in
                showCheckmark()
            } else {
                //animate out
                hideCheckmark()
            }
        }
    }

    var floatingLabel: UILabel = UILabel()
    private let bottomBorder = UIView()

    private var labelBottomConstraintConstraint = NSLayoutConstraint()

    // input spacing - for a proper icon placement, the right edge inset guarantees, that we do not have text below the image view
    private let padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 32)

    //Add icons inside a stack view, to make it easy to add leading or trailing second icons
    private let iconContainerView = UIStackView()

    private let checkmarkImageView = UIImageView(image: UIImage(named: "task"))

    /**
    The text value of the floating label
     */
    @IBInspectable
    var labelText: String?

    @IBInspectable
    var activeBorderColor: UIColor = .swmBlue

    @IBInspectable
    var floatingLabelColor: UIColor = .brownGrey {
        didSet {
            floatingLabel.textColor = floatingLabelColor
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        checkmarkImageView.alpha = Visibility.hidden
        contentVerticalAlignment = .bottom
        labelText = (labelText != nil) ? labelText : placeholder
        addTarget(self, action: #selector(moveFloatingLabel), for: .editingDidBegin)
        addTarget(self, action: #selector(removeFloatingLabel), for: .editingDidEnd)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        applyStyle()
    }

    private func applyStyle() {
        font = UIFont.copy1SfProDisplayDark

        floatingLabel.font = UIFont.copy2SfProDisplayGrey
        floatingLabel.textColor = .brownGrey
        floatingLabel.text = labelText
        if !isEditing {
            bottomBorder.backgroundColor = .brownGrey
        }
    }

    private func setupView() {
        borderStyle = .none
        addBottomBorder()
        addFloatingLabel()
        addIconContainerView()
//        addTarget(self, action: #selector(userDidStartEditing), for: .touchDown)
    }
    
//      TEST APPROACH TO HANDLE CONSTRAINT ADAPTION ON SMALL DEVICES BETTER THAN NOW
//    @objc func userDidStartEditing() {
//        for constraint in constraints {
//            if constraint.firstItem is FloatingLabelInput {
//                print("Found \(constraint.firstItem)")
//            }
//            if constraint.secondAttribute ==  NSLayoutConstraint.Attribute.bottom {
//                print("I am a \(constraint.firstItem is FloatingLabelInput) and my value is \(constraint.constant)")
//            }
//        }
//    }

    private func addFloatingLabel() {
        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(floatingLabel, aboveSubview: bottomBorder)
        NSLayoutConstraint.activate([
            floatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            floatingLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        labelBottomConstraintConstraint = NSLayoutConstraint(item: bottomBorder, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: floatingLabel, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 8.0)

        addConstraint(labelBottomConstraintConstraint)
    }

    private func addIconContainerView() {

        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(checkmarkImageView, aboveSubview: bottomBorder)

        NSLayoutConstraint.activate([
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 24.0),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24.0),
            checkmarkImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            checkmarkImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

    }

    private func addBottomBorder() {

        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(bottomBorder, at: 0)
        NSLayoutConstraint.activate([
            bottomBorder.heightAnchor.constraint(equalToConstant: 2.0),
            bottomBorder.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.bottomSpaceIntitial),
            bottomBorder.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    @objc func moveFloatingLabel() {
        if value.isEmpty {
            self.placeholder = ""
            labelBottomConstraintConstraint.constant = Constants.bottomSpaceFloating
            UIView.animate(withDuration: AnimationDuration.fast, delay: Delay.none, options: .curveEaseInOut, animations: { [weak self] in
                self?.bottomBorder.backgroundColor = .duskBlue
                self?.layoutIfNeeded()
            })
        }
    }

    @objc func removeFloatingLabel() {
        if value.isEmpty {
            labelBottomConstraintConstraint.constant = Constants.bottomSpaceIntitial
            UIView.animate(withDuration: AnimationDuration.fast, delay: Delay.none, options: .curveEaseInOut, animations: { [weak self] in
                self?.layoutIfNeeded()
            })
        }
    }

    //MARK: Text Alignments
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

}

//MARK: Animations
extension FloatingLabelInput {
    //TODO: These animations should be much more nicer, e.g.
    // scale from 0 to 1.2, with a rotation animation
    private func showCheckmark() {
        UIView.animate(withDuration: AnimationDuration.standard, delay: Delay.none, options: .curveEaseInOut, animations: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.checkmarkImageView.alpha = Visibility.visible
        })
    }

    private func hideCheckmark() {
        UIView.animate(withDuration: AnimationDuration.standard, delay: Delay.none, options: .curveEaseInOut, animations: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.checkmarkImageView.alpha = Visibility.hidden
        })
    }
}

