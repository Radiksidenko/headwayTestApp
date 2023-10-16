//
//  BookDetailsReducer.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 13.10.2023.
//

import ComposableArchitecture
import StoreKit

enum BaseError: Error {
    case somethingWentWrong
}

//struct BuyOption {
//    let price: Double // Change to Currency or Decimal
//    let description: String
//    let inAppId: String
//}

struct BookDetailsReducer: ReducerProtocol {
    
    private let skManager = StoreKitManager()
    
    struct State: Equatable {
        var bookId: Int = 0
        var book: Book?
        var shouldOpenPlayer = false
        var product: Product?
        var subscription: Product?
        var isPurchased = false
        var shouldOpenBuyAlert: Bool = false
    }
    
    enum Action: Equatable {
        case fetchBook
        case productLoaded(TaskResult<Product>)
        case subscriptionLoaded(TaskResult<Product>)
        case openPlayer(isPresented: Bool)
        case openBuyAlert(isPresented: Bool)
        case listenButtonTaped
        case readButtonTaped
        case buyButtonTaped
        case buySubscriptionTaped
        case isPurchased(Bool)
    }
    
    
    private func fetchBook(state: inout State) -> EffectTask<Action> {
        
        let allBooks = Book.allBook
        let currentBook = allBooks.first { $0.id == state.bookId }
        state.book = currentBook
        
        return .run { [inAppId = state.book?.inAppId] send in
            
            guard let inAppId = inAppId,
                  let product = await skManager.fetchOneProduct(id: inAppId),
                  let subscription = await skManager.fetchOneProduct(id: MockStoreKit.subscriptionsIds[0])
            else { return await send(.productLoaded(.failure(BaseError.somethingWentWrong)))}
            await send(.productLoaded(.success(product)))
            await send(.subscriptionLoaded(.success(subscription)))
        }
    }
    
    private func buySubscriptionTaped(state: inout State) -> EffectTask<Action> {
        
       
        return .run { send in
            
            guard let product = await skManager.fetchOneProduct(id: MockStoreKit.subscriptionsIds[0]) //TODO: Edit
            else { return await send(.productLoaded(.failure(BaseError.somethingWentWrong)))}
            
            
            guard await skManager.purchase(product: product) != nil
            else {
                return await send(.isPurchased(false))
            }
            await send(.isPurchased(true))
            await send(.openBuyAlert(isPresented: false))
        }
    }
    
    private func buyButtonTaped(state: inout State) -> EffectTask<Action> {
        
        return .run { [product = state.product] send in
            guard let product = product,
                  await skManager.purchase(product: product) != nil
            else {
                return await send(.isPurchased(false))
            }
            await send(.isPurchased(true))
            await send(.openBuyAlert(isPresented: false))
        }
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
            
        case .fetchBook:
            return fetchBook(state: &state)
        
        case .buyButtonTaped:
            return buyButtonTaped(state: &state)
        
        case .buySubscriptionTaped:
            return buySubscriptionTaped(state: &state)
            
        case let .productLoaded(.success(product)):
            state.product = product
            return .run { [inAppId = state.book?.inAppId] send in
                let product = await skManager.isPurchased(productID: inAppId ?? "")
                await send(.isPurchased(product))
            }
        case let .subscriptionLoaded(result):
            switch result {
            case .success(let subscription):
                state.subscription = subscription
            case .failure(_):
                state.subscription = nil
            }
            return .run { send in
                let product = await skManager.isPurchased(productID: MockStoreKit.subscriptionsIds[0])
                await send(.isPurchased(product))
            }
            
        case .productLoaded(.failure(_)):
            return .none
            
        case .isPurchased(let isPurchased):
            if !state.isPurchased {//TODO: Edit race condition
                state.isPurchased = isPurchased
            }
            
        case .listenButtonTaped, .readButtonTaped:
            
            if state.isPurchased {
                return .run { send in
                    await send(.openPlayer(isPresented: true))
                }
            } else {
                return .run { send in
                    await send(.openBuyAlert(isPresented: true))
                }
            }
            
        case .openPlayer(let isPresented):
            state.shouldOpenPlayer = isPresented
        case .openBuyAlert(isPresented: let isPresented):
            state.shouldOpenBuyAlert = isPresented
        }
        return .none
    }
}
