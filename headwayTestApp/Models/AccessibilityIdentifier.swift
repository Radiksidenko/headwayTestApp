//
//  AccessibilityIdentifier.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 17.10.2023.
//

enum AccessibilityIdentifier: String {
    
    enum BookShelf: String {
        case titleLabel = "HeadwayTestApp.BookShelf.titleLabel"
        case bookImage = "HeadwayTestApp.BookShelf.bookImage"
        case bookTitle = "HeadwayTestApp.BookShelf.bookTitle"
        case pictureView = "HeadwayTestApp.BookShelf.pictureView"
    }
    
    enum PlaceholderImage: String {
        case titleLabel = "HeadwayTestApp.PlaceholderImage.titleLabel"
    }
    case base = ""
}
