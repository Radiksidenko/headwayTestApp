//
//  MainStruct.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 10.10.2023.
//

import SwiftUI

@main
struct MainStruct: App {
    
    @State var endanimated: Bool = false
    @State var audioManager: AudioManager = .init()
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                TabView {
                    Home()
                        .environmentObject(audioManager)
                        .tabItem {
                            Image(systemName: "book.fill")
                            Text("Books")
                        }
                    
                    PurchaseList()
                        .environmentObject(audioManager)
                        .tabItem {
                            Image(systemName: "books.vertical.fill")
                            Text("My Book")
                        }
                }
                
                SplashScreen(endanimated: $endanimated)
            }
        }
    }
}
