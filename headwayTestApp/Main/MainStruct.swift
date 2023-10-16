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
    
    enum Style {
        enum Image {
            static let book = "book.fill"
            static let myBook = "books.vertical.fill"
        }
        static let bookPageTitle = "Books" //Add Localization
        static let myBookPageTitle = "My Book"
    }
    var body: some Scene {
        WindowGroup {
            ZStack{
                TabView {
                    Home()
                        .tabItem {
                            Image(systemName: Style.Image.book)
                            Text(Style.bookPageTitle)
                        }
                    
                    PurchaseList()
                        .tabItem {
                            Image(systemName: Style.Image.myBook)
                            Text(Style.myBookPageTitle)
                        }
                }
                
                SplashScreen(endanimated: $endanimated)
            }
        }
    }
}
