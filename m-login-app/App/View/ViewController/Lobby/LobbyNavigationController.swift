//
//  LobbyNavigationController.swift
//  m-login-app
//
//  Created by Normann Joseph on 23.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

class LobbyNavigationController: UINavigationController, DeviceAwareness {

    private let titleLabel = UILabel()
    private let sublineLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeFullyTransparentNavigationBar()
        setupNavigationBackground()
        setupHeadlines()
        delegate = self
    }

    //MARK: - public
    public func setHeader(title: String?, subline: String?) {
        if let title = title {
            titleLabel.text = title
        }

        if let subline = subline {
            sublineLabel.text = subline
        }
    }

    //TODO: Nice to have - The current show segue darkens the screen slightly during animation.
    //      It would be epic to implement a custom show segue, which does not add this darkening effect
    private func setupNavigationBackground() {
        let backgroundImageView = UIImageView(image: UIImage(named: "headerHg"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.insertSubview(backgroundImageView, at: 0)
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupHeadlines() {
        layoutHeadlines()
        applyHeadlineStyles()
    }

    private func layoutHeadlines() {
        titleLabel.text = "1/5"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        view.insertSubview(titleLabel, at: 1)

        sublineLabel.text = "PageTitle"
        sublineLabel.translatesAutoresizingMaskIntoConstraints = false
        sublineLabel.textAlignment = .center
        view.insertSubview(sublineLabel, at: 1)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: isSmallDevice ? 60.0 : 84.0),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sublineLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sublineLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0),
            sublineLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func applyHeadlineStyles() {
        titleLabel.font = UIFont.systemFont(ofSize: 28.0, weight: .light)
        titleLabel.textColor = .white
        sublineLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .regular)
        sublineLabel.textColor = .white
    }

    private func makeFullyTransparentNavigationBar() {

        if let rootView = viewControllers.first as? LobbyViewController,
            let navigationBar = rootView.navigationController?.navigationBar {
            navigationBar.shadowImage = UIImage()
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.isTranslucent = true
            navigationBar.tintColor = .white
        }

    }
}


extension LobbyNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return SlideInPushAnimator()
        case .pop:
            return SlideOutPushAnimator()
        default:
            return nil
        }
    }
}
