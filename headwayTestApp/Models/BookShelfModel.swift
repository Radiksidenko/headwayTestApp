//
//  BookShelf.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 12.10.2023.
//

import Foundation

struct BookShelfModel: Equatable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let books: [Book]
}
