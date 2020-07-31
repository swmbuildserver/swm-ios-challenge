//
//  MLoginCoreTests.swift
//  m-login-appTests
//
//  Created by Normann Joseph on 06.04.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import XCTest

class MLoginCoreTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDummySaysYiha() {
        let expectation = "Yiha!"
        XCTAssertEqual(expectation, MLoginCore.shared.dummyValue, "dummy is not as expected")

    }

}
