//
//  BookDetails.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 12.10.2023.
//

import SwiftUI
import ComposableArchitecture

struct BookDetails: View {
    var id: Int
    
    var body: some View {
        BookDetailsView(
            store: Store(
                initialState: BookDetailsReducer.State(bookId: id),
                reducer: { BookDetailsReducer() }
            )
        )
    }
}
