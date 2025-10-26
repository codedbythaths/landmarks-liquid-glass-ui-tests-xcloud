//
//  LandmarksUITests.swift
//  LandmarksUITests
//
//  Created by Thathsara Amarakoon on 27/10/2025.
//  Copyright © 2025 Apple. All rights reserved.
//

import XCTest

final class LandmarksUITests: BaseTestCase {

    @MainActor
    func testCreateCollectionWithLandMarks() throws {
            // MARK: - Arrange
            let collectionName = "Max's Australian Adventure"
            let landmarkIndex = 1
            let continentSection = "LandmarksSelectionList.section.Australia/Oceania"
            let timeout: TimeInterval = 5.0
            
            // MARK: - Navigate to Collections View
            let backButton = app.buttons["BackButton"].firstMatch
            XCTAssertTrue(backButton.waitForExistence(timeout: timeout),
                          "Back button should exist")
            backButton.tap()
            
            let collectionsOption = app.staticTexts["SplitView.sidebar.row.Collections"].firstMatch
            XCTAssertTrue(collectionsOption.waitForExistence(timeout: timeout),
                          "Collections option should exist")
            collectionsOption.tap()
            
            // MARK: - Create New Collection
            let addButton = app.buttons["collectionsView.toolbar.addCollectionButton"].firstMatch
            XCTAssertTrue(addButton.waitForExistence(timeout: timeout),
                          "Add collection button should exist")
            addButton.tap()
            
            let editButton = app.buttons["Edit"].firstMatch
            XCTAssertTrue(editButton.waitForExistence(timeout: timeout),
                          "Edit button should exist")
            editButton.tap()
            
            // MARK: - Enter Collection Name
            let nameField = app.textFields["Name"].firstMatch
            XCTAssertTrue(nameField.waitForExistence(timeout: timeout),
                          "Name field should exist")
            nameField.doubleTap()
            nameField.typeText(collectionName)
            
//            // Verify name was entered
//            XCTAssertTrue(nameField.value as? String == collectionName,
//                          "Collection name should be entered correctly")
            
            // MARK: - Select Landmark
            let landmarksButton = app.buttons["CollectionEdit.root.1006"].firstMatch
            XCTAssertTrue(landmarksButton.waitForExistence(timeout: timeout),
                          "Landmarks selector button should exist")
            landmarksButton.tap()
            
            // Scroll to find the continent section
            let scrollView = app.otherElements["Vertical scroll bar, 3 pages"].firstMatch
            XCTAssertTrue(scrollView.waitForExistence(timeout: timeout),
                          "Scroll view should exist")
            scrollView.swipeUp()
            
            // Select landmark from continent section
            let continentImages = app.images.matching(identifier: continentSection)
            XCTAssertTrue(continentImages.count > landmarkIndex,
                          "Should have landmarks in the continent section")
            continentImages.element(boundBy: landmarkIndex).tap()
            
            // MARK: - Complete Collection Creation
            let landmarksDoneButton = app.buttons["LandmarksSelectionList.toolbar.doneButton"].firstMatch
            XCTAssertTrue(landmarksDoneButton.waitForExistence(timeout: timeout),
                          "Landmarks done button should exist")
            landmarksDoneButton.tap()
            
            let saveButton = app.buttons["checkmark"].firstMatch
            XCTAssertTrue(saveButton.waitForExistence(timeout: timeout),
                          "Save button should exist")
            saveButton.tap()
            
//            // MARK: - Assert: Verify Collection Was Created
//            let createdCollection = app.staticTexts[collectionName].firstMatch
//            XCTAssertTrue(createdCollection.waitForExistence(timeout: timeout),
//                          "Collection '\(collectionName)' should be created and displayed")
//            XCTAssertTrue(createdCollection.isHittable,
//                          "Created collection should be visible and accessible")
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
