//
//  BottomSheet.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 16.10.2023.
//

import SwiftUI

private enum Style {
    static let readButtonIcon = "text.alignleft"
    static let readButtonText = "Read"
    static let listenButtonIcon = "headphones"
    static let listenButtonText = "Listen"
    static let heightButton = 40.0
    static let basePadding = 15.0
}

struct BottomSheet: View {
    
    let buttonHeight: CGFloat = 55
    let action: () -> Void
    let action2: () -> Void
    let price1: String
    let price2: String
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            
            CloseButton().frame(alignment: .leading)
            
            VStack(alignment: .center, spacing: 20) {
                Text("Unlock learning")
                    .foregroundColor(.black.opacity(0.9))
                    .font(.system(size: 20, weight: .bold))
                    .frame(alignment: .center)
                    .multilineTextAlignment(.center)
                
                Text("Grow on the reading go by listening and the world's best ideas")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black.opacity(0.7))
                    .padding(.bottom, 24)
                
                BaseButton(action: {
                    action()
                }, content: {
                    HStack {
                        Image(systemName: "book.closed.fill")
                        Text("One Book " + price1)
                    }
                    .frame(height: Style.heightButton)
                    .frame(maxWidth: .infinity)
                })
                .padding([.leading, .trailing], Style.basePadding)
                .frame(maxHeight: .infinity, alignment: .bottom)
                
                BaseButton(action: {
                    action2()
                }, color: .blue, content: {
                    HStack {
                        Image(systemName: "wallet.pass.fill")
                        Text("All Books " + price2)
                    }
                    .frame(height: Style.heightButton)
                    .frame(maxWidth: .infinity)
                })
                .padding([.leading, .trailing], Style.basePadding)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .padding(.top, 20)
            .padding(.horizontal, 16)
            
        }
    }
}
