//
//  BaseTestCase.swift
//  Landmarks
//
//  Created by Thathsara Amarakoon on 27/10/2025.
//  Copyright © 2025 Apple. All rights reserved.
//

import XCTest

class BaseTestCase: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {

        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {

    }
    
    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
