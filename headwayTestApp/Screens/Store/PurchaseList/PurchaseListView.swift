//
//  PurchaseListView.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 15.10.2023.
//

import SwiftUI
import StoreKit/////
import ComposableArchitecture

struct PurchaseListView: View {
    let store: StoreOf<PurchaseListReducer>
    
    var body: some View {
        
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            
            NavigationView {
                VStack {
                    if let myBooksShelf = viewStore.myBooksShelf {
                        BookShelf(bookShelf: myBooksShelf, onTapped: { id in
                            viewStore.send(.openBook(isPresented: true))
                            viewStore.send(.selectBook(id: id))
                        }).padding(.top, 30)
                    }
                    if let myBooksShelf = viewStore.mySubscriptionsShelf {
                        BookShelf(bookShelf: myBooksShelf, onTapped: { _ in
                            print("mySubscriptionsShelf")
                        }).padding(.top, 30)
                    }
                }
            }
            .navigationTitle("Purchases")
            .onAppear {
                viewStore.send(.fetchProduct)
            }
            .sheet(
                isPresented: viewStore.binding(
                    get: \.shouldOpenBook,
                    send: PurchaseListReducer.Action.openBook(isPresented:)
                )
            ) {
                BookDetails(id: viewStore.selectedBookId)
            }
        }
    }
}
