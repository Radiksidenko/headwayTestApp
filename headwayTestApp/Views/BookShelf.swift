//
//  Shelf.swift
//  headwayTestApp
//
//  Created by Radomyr Sidenko on 12.10.2023.
//

import SwiftUI

struct BookShelf: View {
    let bookShelf: BookShelfModel
    let onTapped: (Int) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(bookShelf.title)
                .font(.largeTitle)
                .multilineTextAlignment(.leading)
                .padding(.leading, 15)
                .accessibilityIdentifier(AccessibilityIdentifier.BookShelf.titleLabel.rawValue)
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack {
                    ForEach(bookShelf.books) { book in
                        Button(
                            action: {
                                onTapped(book.id)
                            }, label: {
                                PictureView(book: book)
                            }
                        ).accessibilityIdentifier(AccessibilityIdentifier.BookShelf.pictureView.rawValue)
                    }
                }
            })
            .padding(.bottom, 40.0)
        }
    }
}

private struct PictureView: View {
    var book: Book
    
    var body: some View {
        VStack {
            Image(book.imageString)
                .resizable()
                .frame(width: 120.0, height: 180.0)
                .cornerRadius(10)
                .accessibilityIdentifier(AccessibilityIdentifier.BookShelf.bookImage.rawValue)
            
            Text(book.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.leading)
                .font(.subheadline)
                .lineLimit(2)
                .frame(height: 40.0)
                .accessibilityIdentifier(AccessibilityIdentifier.BookShelf.bookTitle.rawValue)
        }
        .frame(width: 150)
    }
}
