//
//  AddBookView.swift
//  Bookworm
//
//  Created by Ángel Vázquez on 17/11/19.
//  Copyright © 2019 Ángel Vázquez. All rights reserved.
//

import SwiftUI

struct AddBookView: View {
    
    // MARK: - Environment
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    // MARK: - State
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    // MARK: - Properties
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    // MARK: - View protocol
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: self.moc)
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre
                        
                        if self.review.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            newBook.review = "No review"
                        } else {
                            newBook.review = self.review
                        }
                        
                        newBook.date = Date()

                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(isFormCorrectlyFilled())
                }
            }
            .navigationBarTitle("Add Book")
        }
    }
    
    private func isFormCorrectlyFilled() -> Bool {
        let isTitleFilled = title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isAuthorFilled = author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isGenreFilled = genre.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        return isTitleFilled || isAuthorFilled || isGenreFilled
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
