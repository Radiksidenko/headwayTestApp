//
//  HomeReducer.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 11.10.2023.
//

import SwiftUI
import ComposableArchitecture

struct HomeReducer: ReducerProtocol {
    
    struct State: Equatable {
        var bookShelfList: [BookShelfModel] = BookShelfModel.sample
        var shouldOpenBook = false
        var selectedBookId: Int = 0
    }
    
    enum Action: Equatable {
        case openBook(isPresented: Bool)
        case selectBook(id: Int)
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
            
        case .openBook(let isPresented):
            state.shouldOpenBook = isPresented
            
        case .selectBook(let bookId):
            state.selectedBookId = bookId
            
        }
        return .none
    }
}
