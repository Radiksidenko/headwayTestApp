//
//  BookPlayer.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 15.10.2023.
//

import SwiftUI
import ComposableArchitecture

struct BookPlayer: View {
    
    var book: Book
    
    var body: some View {
        BookPlayerView(
            store: Store(
                initialState: BookPlayerReducer.State(book: book),
                reducer: { BookPlayerReducer() }
            )
        )
    }
}
