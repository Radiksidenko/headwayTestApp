//
//  headwayTestAppTests.swift
//  headwayTestAppTests
//
//  Created by Radomyr Sidenko on 10.10.2023.
//

import XCTest
@testable import headwayTestApp
import SwiftUI
import SnapshotTesting

private func getSize() -> CGRect {
    return CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
}

final class headwayTestAppTests: XCTestCase {

    func testHomeScreen() {
        
        let homeScreen = Home()
        let view: UIView = UIHostingController(rootView: homeScreen).view
        view.frame = getSize()
        assertSnapshot(matching: view, as: .image)
    }
    
    func testBookShelf() {
        
        let bookShelfModel = BookShelfModel.sample[0]
        let bookShelfView = BookShelf(bookShelf: bookShelfModel, onTapped: {_ in })
        let view: UIView = UIHostingController(rootView: bookShelfView).view
        view.frame = getSize()
        assertSnapshot(matching: view, as: .image)
    }
    
    func testPlaceholderImage() {
        
        let book = Book.sample1
        let placeholderImage = PlaceholderImage(
            title: book.title,
            description: book.description,
            imageString: book.imageString
        )
        let view: UIView = UIHostingController(rootView: placeholderImage).view
        view.frame = getSize()
        assertSnapshot(matching: view, as: .image)
    }
}
