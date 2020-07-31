//
//  RoundedButton.swift
//  m-login-app
//
//  Created by Normann Joseph on 23.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

@IBDesignable
public class RoundedButton: UIControl, DeviceAwareness {

    private struct Constants {
        static let defaultTitle = "PLACEHOLDER"
        static let horizontalSpacing: CGFloat = 16.0
        static let ctaFontSize: CGFloat = 17.0
        static let defaultBorderWidth: CGFloat = 2.0
    }

    public enum Theme: Int, CaseIterable {
        case solid, bordered, blueGradient
    }

    //MARK - init

    init(theme: Theme = .solid) {
        super.init(frame: .zero)
        self.theme = theme
        setupView()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    public override func prepareForInterfaceBuilder() {
        setupView()
    }

    // MARK: - Public Properties

    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        // Prohibit bad design (linebreaks)
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.text = title
        label.textAlignment = .center
        titleForState[.normal] = title
        return label
    }()

    public var theme: Theme = .solid {
        didSet {
            setupView()
        }
    }

    @IBInspectable public var buttonStyle: String = "solid" {
        didSet {
            switch buttonStyle {
            case "solid":
                theme = .solid
            case "bordered":
                theme = .bordered
            case "blueGradient":
                theme = .blueGradient
            default:
                theme = .solid
            }
        }
    }

    // MARK: - Private Properties
    private func arrangeButtonSubviews() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            heightAnchor.constraint(equalToConstant: isSmallDevice ? 44.0 : 60.0)
            ])
    }

    // MARK: - Inspectable Properties

    @IBInspectable public var title: String = Constants.defaultTitle {
        didSet {
            titleForState[.normal] = title
            updateTitle(for: .normal)
        }
    }

    @IBInspectable public var isActive: Bool = true {
        didSet {
            self.isUserInteractionEnabled = isActive
            updateTheme()
        }
    }

    @IBInspectable public var fillColor: UIColor = .white
    @IBInspectable public var borderColor: UIColor = .white

    //MARK: - private helpers
    private var titleForState = [UIControl.State: String]()

    private let gradientLayer = CAGradientLayer()

    private func setupView() {

        layer.cornerRadius = isSmallDevice ? 22.0 : 30.0
        clipsToBounds = true

        if theme == .bordered {
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = Constants.defaultBorderWidth
            backgroundColor = .clear
        }

        addSubview(titleLabel)

        arrangeButtonSubviews()
        updateTheme()
        updateTitle(for: .normal)
    }


    /// Update the current displayed title if needed.
    private func updateTitle(for state: UIControl.State) {
        guard self.state == state else {
            return
        }

        if let title = titleForState[state] {
            titleLabel.text = title
            titleLabel.font = UIFont.systemFont(ofSize: Constants.ctaFontSize, weight: .medium)
        }
    }

    private func updateTheme() {
        switch theme {
        case .solid:
            if isActive {
                backgroundColor = fillColor
            } else {
                backgroundColor = .lightGrey
            }
            titleLabel.textColor = .swmBlue
        case .bordered:
            backgroundColor = .clear
            if isActive {
                titleLabel.textColor = fillColor
                layer.borderColor = borderColor.cgColor
            } else {
                titleLabel.textColor = .lightGrey
                layer.borderColor = UIColor.lightGrey.cgColor
            }
        case .blueGradient:
            if isActive {
                addBlueGradient()
            } else {
                fadeToInactive()
                backgroundColor = .lightGrey
            }
            titleLabel.textColor = .white
        }
    }

    private func updateThemeForTouch() {
        switch theme {
        case .solid:
            backgroundColor = .lightGrey
        case .bordered, .blueGradient:
            titleLabel.textColor = .lightGrey
            layer.borderColor = UIColor.lightGrey.cgColor
        }
    }

    private func addBlueGradient() {

        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.brightBlue.cgColor, UIColor.duskBlue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.shouldRasterize = false

        fadeToActive()
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        updateThemeForTouch()
        sendActions(for: .touchDown)
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        updateTheme()
        sendActions(for: .touchCancel)
    }

    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        updateTheme()
        sendActions(for: .touchCancel)
    }
}

// MARK: - Animations

extension RoundedButton {

    private func fadeToActive() {
        UIView.transition(with: self,
                          duration: AnimationDuration.fast,
                          options: UIView.AnimationOptions.transitionCrossDissolve,
                          animations: { [weak self] () -> Void in
                            guard let strongSelf = self else { return }
                            strongSelf.layer.insertSublayer(strongSelf.gradientLayer, at: 0)
            }, completion: nil)
    }

    private func fadeToInactive() {
        UIView.transition(with: self,
                          duration: AnimationDuration.fast,
                          options: UIView.AnimationOptions.transitionCrossDissolve,
                          animations: { [weak self] () -> Void in
                            guard let strongSelf = self else { return }
                            strongSelf.gradientLayer.removeFromSuperlayer()
            }, completion: nil)
    }
}

// MARK: - Private Extensions

extension UIControl.State: Hashable {}
