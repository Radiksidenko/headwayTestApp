//
//  Book.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 12.10.2023.
//

import Foundation

struct Book: Equatable, Identifiable {
    let id: Int
    let title: String
    let price: Double // Change to Currency or Decimal
    let description: String
    let category: String // Change to enum
    let imageString: String
    let author: String // Change to Array
    let inAppId: String
    let content: URL //Change
}
