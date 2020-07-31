//
//  AccountCreationBaseViewController.swift
//  m-login-app
//
//  Created by Normann Joseph on 24.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import Combine
import UIKit

enum AccountCreationOverlayDetailContext {
    case dataAccess
}

protocol AccountCreationFlowDelegate: class {
    func proceed(viewModel: AccountCreationViewModel)
    func skip(viewModel: AccountCreationViewModel)
    func showDetailViewController(for context: AccountCreationOverlayDetailContext)
}

class AccountCreationBaseViewController: UIViewController, Movable, DeviceAwareness {

    private struct Constants {
        static let inputBottomAnchorConstraintIdentifier = "bottomConstraint"
    }

    @IBOutlet weak var progressBar: ProgressBarView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var proceedButton: RoundedButton!
    @IBOutlet weak var cardView: CardView!

    @IBOutlet weak var progressBarTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomSpaceConstraint: NSLayoutConstraint!

    var accountCreationViewModel: AccountCreationViewModel!

    /**
     The Bottom constraint which should be set on the lowest available input element.
     This guarantees visibility, when the keyboard is presented
     */
    var bottomViewConstraint: NSLayoutConstraint?

    weak var delegate: AccountCreationFlowDelegate?

    // MARK: - Private properties
    var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        accountCreationViewModel.navigationController = navigationController as? LobbyNavigationController
        accountCreationViewModel.progressBar = progressBar
        setupKeyboardHandling()
        setupCardView()
    }

    private func setupCardView() {
        headlineLabel.font = isSmallDevice ? UIFont.h1SfProDisplayDarkSmall : UIFont.h1SfProDisplayDark
        bottomSpaceConstraint.constant = isSmallDevice ? 44.0 : 104.0
    }

    private func setupKeyboardHandling() {
        //only add keyboard handling if a bottom constraint is connected
        guard let bottomViewConstraint = cardView.constraintWithIdentifier(Constants.inputBottomAnchorConstraintIdentifier) else { return }
        self.bottomViewConstraint = bottomViewConstraint
        accountCreationViewModel.initialBottomConstraintConstant = bottomViewConstraint.constant

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        let cardViewTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        cardViewTap.delegate = self
        view.addGestureRecognizer(cardViewTap)
    }

    func setupViews() {
        proceedButton.title = String.localized(key: "ButtonProceed")
        headlineLabel.text = accountCreationViewModel.cardTitle
    }

    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @IBAction func userDidTapProceedButton(_ sender: Any) {
        delegate?.proceed(viewModel: accountCreationViewModel)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        /**
         We  calculate the y position of the keyboard on screen, and increase the bottom layout. This moves the whole card content
         to the top, and guarantees that the entry form is not covered by the keyboard
         */

        guard let keyboardOriginY = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.origin.y else { return }

        // This is some Magic Number Voodoo to meet keyboard height
        // Should be refactored one day
        let bloodMagicOffset = CGFloat(isSmallDevice ? 84.0 : 104.0)
        let proceedButtonYPositon = proceedButton.frame.origin.y + bloodMagicOffset

        if keyboardOriginY < proceedButtonYPositon {
            let offset = proceedButtonYPositon - keyboardOriginY
            updateConstraint(bottomViewConstraint, newValue: offset + bloodMagicOffset)
        }

    }

    @objc func keyboardWillHide(notification: NSNotification) {
        //reset the bottom constraint to its initial value
        updateConstraint(bottomViewConstraint, newValue: accountCreationViewModel.initialBottomConstraintConstant)
    }
}

//MARK: Helper Functions
extension AccountCreationBaseViewController {

    func createLinkInTextView(inputText: String, needles: [String : String], targetView: UITextView) {

        let attributedString = NSMutableAttributedString(string: inputText)

        inputText.enumerateSubstrings(in: inputText.startIndex..<inputText.endIndex, options: .byWords) {
            (substring, substringRange, _, _) in
            let text = inputText

            for needle in needles {
                if substring == needle.key {
                    attributedString.addAttribute(.link, value: needle.value,
                                                  range: NSRange(substringRange, in: text))
                }
            }

        }
        targetView.attributedText = attributedString

    }

}

//MARK: Delegates
extension AccountCreationBaseViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension AccountCreationBaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let isControlTapped = touch.view is UIControl
        return !isControlTapped
    }
}
