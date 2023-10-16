//
//  MockManager.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 16.10.2023.
//

import Foundation

//MARK: -MockStoreKit-
enum MockStoreKit {
    static let subscriptionsIds = ["com.headway.AllBooks"]
    static let nonConsumableProductsIds = [
        "com.headway.HitchhikerGalaxy",
        "com.headway.ReadyPlayerOne",
        "com.headway.ReadyPlayerTwo"
    ]
}

//MARK: -BookShelf-
extension BookShelfModel {
    static var sample: [BookShelfModel] {
        [
            .init(id: 1, title: "Up Next", description: "", books: [Book.sample1, Book.sample2]),
            .init(id: 2, title: "New Book Releases", description: "", books: [Book.sample3])
        ]
    }
}

//MARK: -Book-

enum AudioContentMock {
#if E2ETest
    static let sample1 = URL(fileURLWithPath: Bundle(for: headwayTestAppUITests.self).path(forResource: "HitchhikerGuide", ofType: "mp3")!)
    static let sample2 = URL(fileURLWithPath:Bundle(for: headwayTestAppUITests.self).path(forResource: "ReadyPlayerOne", ofType: "mp3")!)
    static let sample3 = URL(fileURLWithPath:Bundle(for: headwayTestAppUITests.self).path(forResource: "ReadyPlayerTwo", ofType: "mp3")!)
#else
    static let sample1 = URL(fileURLWithPath: Bundle.main.path(forResource: "HitchhikerGuide", ofType: "mp3")!)
    static let sample2 = URL(fileURLWithPath: Bundle.main.path(forResource: "ReadyPlayerOne", ofType: "mp3")!)
    static let sample3 = URL(fileURLWithPath: Bundle.main.path(forResource: "ReadyPlayerTwo", ofType: "mp3")!)
#endif
}

extension Book {
    static var sample1: Book {
        .init(
            id: 1,
            title: "The Hitchhiker's Guide to the Galaxy",
            price: 10,
            description: "Don't panic",
            category: "",
            imageString: "HitchhikerGuide",
            author: "Douglas Adams",
            inAppId: "com.headway.HitchhikerGalaxy",
            content: AudioContentMock.sample1
        )
    }
    static var sample2: Book {
        .init(
            id: 2,
            title: "Ready Player One",
            price: 10,
            description: "Easter Egg",
            category: "",
            imageString: "ReadyPlayerOne",
            author: "Ernest Cline",
            inAppId: "com.headway.ReadyPlayerOne",
            content: AudioContentMock.sample2
        )
    }
    static var sample3: Book {
        .init(
            id: 3,
            title: "Ready Player Two",
            price: 10,
            description: "The ONI headsets",
            category: "",
            imageString: "ReadyPlayerTwo",
            author: "Ernest Cline",
            inAppId: "com.headway.ReadyPlayerTwo",
            content: AudioContentMock.sample3
        )
    }
    
    static var allBook: [Book] = [ sample1, sample2, sample3 ]
}
