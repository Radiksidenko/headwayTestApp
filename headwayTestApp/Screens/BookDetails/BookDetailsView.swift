//
//  BookDetailsView.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 13.10.2023.
//

import SwiftUI
import ComposableArchitecture
import StoreKit

private enum Style {
    static let readButtonIcon = "text.alignleft"
    static let readButtonText = "Read"
    static let listenButtonIcon = "headphones"
    static let listenButtonText = "Listen"
    static let heightButton = 40.0
    static let basePadding = 15.0
}

struct BookDetailsView: View {
    let store: StoreOf<BookDetailsReducer>
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            GeometryReader { proxy in
                
                ZStack(alignment: .topLeading) {
                    CloseButton()
                    
                    VStack {
                        PlaceholderImage(
                            title: viewStore.book?.title ?? "",
                            description: viewStore.book?.description ?? "",
                            secondDescription: viewStore.book?.author ?? "",
                            imageString: viewStore.book?.imageString ?? "HitchhikerGuide") // Change to Blank
                        .padding([.leading, .trailing], Style.basePadding)
                        HStack {
                            BaseButton(action: {
                                viewStore.send(.readButtonTaped)
                            }, content: {
                                HStack {
                                    Image(systemName: Style.readButtonIcon)
                                    Text(Style.readButtonText)
                                }
                                .frame(height: Style.heightButton)
                            })
                            
                            BaseButton(action: {
                                viewStore.send(.listenButtonTaped)
                            }, color: .blue, content: {
                                HStack {
                                    Image(systemName: Style.listenButtonIcon)
                                    Text(Style.listenButtonText)
                                }
                                .frame(height: Style.heightButton)
                                .frame(maxWidth: .infinity)
                            })
                        }
                        .padding([.leading, .trailing], Style.basePadding)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                }
                .onAppear {
                    viewStore.send(.fetchBook)
                }
                .fullScreenCover(
                    isPresented: viewStore.binding(
                        get: \.shouldOpenPlayer,
                        send: BookDetailsReducer.Action.openPlayer(isPresented:)
                    )
                ) {
                    if let book = viewStore.book {
                        BookPlayer(book: book)
                    }
                }
            }
            .background(Color(uiColor: .tertiarySystemGroupedBackground).ignoresSafeArea())
            .sheet(
                isPresented: viewStore.binding(
                    get: \.shouldOpenBuyAlert,
                    send: BookDetailsReducer.Action.openBuyAlert(isPresented:)
                ),
                content: {
                    BottomSheet(
                        action: {
                            viewStore.send(.buyButtonTaped)
                        },
                        action2: {
                            viewStore.send(.buySubscriptionTaped)
                        },
                        price1: "\(viewStore.product?.price ?? 0)",
                        price2: "\(viewStore.subscription?.price ?? 0)"
                    )
                    .presentationDetents([.height(300)])
                })
        }
    }
}
