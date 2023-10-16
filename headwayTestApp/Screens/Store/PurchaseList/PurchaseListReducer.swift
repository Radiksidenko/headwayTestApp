//
//  PurchaseListReducer.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 16.10.2023.
//

import ComposableArchitecture
import StoreKit

struct PurchaseListReducer: ReducerProtocol {
    
    private let skManager = StoreKitManager()
    
    struct State: Equatable {
        var purchasedSubscriptions: [Product] = []
        var myBooksShelf: BookShelfModel?
        var mySubscriptionsShelf: BookShelfModel?
        var shouldOpenBook = false
        var selectedBookId: Int = 0
    }
    
    enum Action: Equatable {
        case fetchProduct
        case productLoaded(TaskResult<[Product]>)
        case subscriptions(TaskResult<[Product]>)
        case openBook(isPresented: Bool)
        case selectBook(id: Int)
    }
    
    private func fetchProduct(state: inout State) -> EffectTask<Action> {
        return .run { send in
            let product = await skManager.fetchPurchasedProducts()
            await send(.productLoaded(.success(product)))
            
            let subscriptions = await skManager.fetchPurchasedSubscriptions()
            await send(.subscriptions(.success(subscriptions)))
        }
    }
    private func productLoaded(state: inout State, result: TaskResult<[Product]>) -> EffectTask<Action> {
        switch result {
        case .success(let product):
            let allBooks = Book.allBook
            let myBooks = product.map { book in ///TODO: EDIT
                allBooks.first { $0.inAppId == book.id }
            }.compactMap { $0 }
            state.myBooksShelf = BookShelfModel(id: 1, title: "My Books", description: "", books: myBooks)
        case .failure(_):
            state.myBooksShelf = nil
        }
        return .none
    }
    
    private func subscriptionsLoaded(state: inout State, result: TaskResult<[Product]>) -> EffectTask<Action> {
        switch result {
        case .success(let subscription):
            if subscription.count > 0,
               let subscription = subscription.first {
                let myBooks = [Book(id: 1, title: subscription.displayName, price: 0, description: "", category: "", imageString: "", author: "", inAppId: "com.headway.AllBooks", content: URL(filePath: ""))]
                state.mySubscriptionsShelf = BookShelfModel(id: 1, title: "My Subscriptions", description: "", books: myBooks)
            }
        case .failure(_):
            state.myBooksShelf = nil
        }
        return .none
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
            
        case .fetchProduct:
            state.myBooksShelf = nil
            return fetchProduct(state: &state)
            
        case .productLoaded(let result):
            return productLoaded(state: &state, result: result)
        
        case .subscriptions(let result):
            return subscriptionsLoaded(state: &state, result: result)
        case .openBook(let isPresented):
            state.shouldOpenBook = isPresented
            
        case .selectBook(let bookId):
            state.selectedBookId = bookId
        }
        return .none
    }
}
