//
//  PurchaseList.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 16.10.2023.
//

import SwiftUI
import ComposableArchitecture

struct PurchaseList: View {
    
    var body: some View {
        PurchaseListView(
            store: Store(
                initialState: PurchaseListReducer.State(),
                reducer: { PurchaseListReducer() }
            )
        )
    }
}
