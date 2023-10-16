//
//  HomeView.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 12.10.2023.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    let store: StoreOf<HomeReducer>
    
    var body: some View {
        
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                ForEach(viewStore.bookShelfList) { bookShelf in
                    VStack {
                        BookShelf(bookShelf: bookShelf, onTapped: { id in
                            viewStore.send(.openBook(isPresented: true))
                            viewStore.send(.selectBook(id: id))
                        })
                    }.padding(.top, 30)
                }
            }
            .sheet(
                isPresented: viewStore.binding(
                    get: \.shouldOpenBook,
                    send: HomeReducer.Action.openBook(isPresented:)
                )
            ) {
                BookDetails(id: viewStore.selectedBookId)
            }
        }
    }
}
