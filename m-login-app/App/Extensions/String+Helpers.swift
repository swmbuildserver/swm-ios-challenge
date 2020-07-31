//
//  String+Helpers.swift
//  m-login-app
//
//  Created by Normann Joseph on 29.06.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import Foundation

extension String {
    static func localized(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}

extension String {

    //Not the final quality - but good enough to start
    func formatPhoneNumber() -> String {
        guard !self.isEmpty else { return "" }
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }

        let phoneNumberRange = NSString(string: self).range(of: self)
        var number = regex.stringByReplacingMatches(in: self, options: .init(rawValue: 0), range: phoneNumberRange, withTemplate: "")

        if number.count < 7 {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{4})(\\d+)", with: "$1 $2", options: .regularExpression, range: range)

        } else {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{4})(\\d{3})(\\d+)", with: "$1 $2 $3", options: .regularExpression, range: range)
        }

        return number
    }
}
