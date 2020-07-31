//
//  CommunicationTESTViewController.swift
//  m-login-app
//
//  Created by Normann Joseph on 22.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

class CommunicationTESTViewController: UIViewController {


    @IBOutlet weak var magicButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!

    var dummyValue = "Lobby"

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = dummyValue
        setupAppObservers()
    }

    private func setupAppObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    @objc private func appDidBecomeActive() {
        magicButton.isEnabled = MLoginCore.shared.externalAppContext != nil

        guard let externalAppContext = MLoginCore.shared.externalAppContext,
            let requestedAction = externalAppContext.requestedAction else {
                return
        }
        magicButton.setTitle("Perform Magic \(requestedAction.rawValue.capitalized)", for: .normal)
    }

    @IBAction func userDidTapPerformMagicLogin(_ sender: Any) {
        guard let externalAppContext = MLoginCore.shared.externalAppContext,
            let requestedAction = externalAppContext.requestedAction,
            let sourceApplicationUrl = URL(string: externalAppContext.sourceApplicationBundle) else {
                return
        }

        switch requestedAction {
        case .login:
            jumpBack(to: URL(string: "\(sourceApplicationUrl.absoluteString)://success?code=1234124&state=0815&sourceAction=\(requestedAction.rawValue)")!)
        default:
            print("Unsupported Action")
        }
    }

    //Todo: Proper Refactoring to service
    private func jumpBack(to url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

}
