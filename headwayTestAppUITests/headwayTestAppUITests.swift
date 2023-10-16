//
//  headwayTestAppUITests.swift
//  headwayTestAppUITests
//
//  Created by Radomyr Sidenko on 10.10.2023.
//

import XCTest

final class headwayTestAppUITests: XCTestCase {

    func testRealLoding() {
        
        let app = XCUIApplication()
        app.launch()
        
        sleep(3)
        
        let window = app.windows.firstMatch
        let titleLabel = window.staticTexts[AccessibilityIdentifier.BookShelf.titleLabel.rawValue].firstMatch
        let titleText = titleLabel.label
        
        let bookShelfTitle = BookShelfModel.sample[0].title
        XCTAssertEqual(titleText, bookShelfTitle)
    }
    
    func testTransition() {
        let app = XCUIApplication()
        app.launch()
        
        sleep(3)
        
        let firstTitle = app.descendants(matching: .any)[AccessibilityIdentifier.BookShelf.bookTitle.rawValue].firstMatch.label
        let pictureView = app.descendants(matching: .any)[AccessibilityIdentifier.BookShelf.pictureView.rawValue].firstMatch
        pictureView.tap()
        let secondTitle = app.descendants(matching: .any)[AccessibilityIdentifier.PlaceholderImage.titleLabel.rawValue].firstMatch.label
        XCTAssertEqual(firstTitle, secondTitle)
    }
}
