//
//  BookPlayerView.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 15.10.2023.
//

import SwiftUI
import ComposableArchitecture

struct BookPlayerView: View {
    
    let store: StoreOf<BookPlayerReducer>
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack(alignment: .topLeading) {
                
                Color(uiColor: .tertiarySystemGroupedBackground).ignoresSafeArea(.all, edges: .all)
                
                CloseButton()
                
                VStack(spacing: 25) {
                    
                    PlaceholderImage(
                        title: viewStore.book?.title ?? "",
                        description: viewStore.book?.description ?? "",
                        imageString: viewStore.book?.imageString ?? "HitchhikerGuide" // Change to Blank
                    )
                    
                    SliderControl(viewStore: viewStore)
                    
                    
                    PlaybackControl(viewStore: viewStore)
                        .padding(.top, 10)
                    
                    ReadAndListen(viewStore: viewStore)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
                .padding(.top, 10)
                .padding([.leading, .trailing], 20)
            }
            .onAppear {
                viewStore.send(.startPlayer)
            }
            .onReceive(timer) { _ in //Just for Fun :)
                if viewStore.isPLaying {
                    viewStore.send(.progressUpdatedByCurrentTime)
                }
            }
        }
    }
}
