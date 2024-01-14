//
//  Book.swift
//  Utils
//
//  Created by Jmy on 2023/09/08.
//

import SwiftUI

struct Book: Identifiable {
    var id = UUID()
    var title: String
    var author: String
    var isbn: String
    var pages: Int
    var isRead: Bool = false
}

extension Book {
    static let samples = [
        Book(title: "Changer", author: "Matt Gemmell", isbn: "9781916265202", pages: 476),
        Book(title: "SwiftUI for Absolute Beginners", author: "Jayant Varma", isbn: "9781484255155", pages: 200),
        Book(title: "Why we sleep", author: "Matthew Walker", isbn: "9780141983769", pages: 368),
        Book(title: "The Hitchhiker's Guide to the Galaxy", author: "Douglas Adams", isbn: "9780671461492", pages: 216),
    ]
}

private class BooksViewModel: ObservableObject {
    @Published var books: [Book] = Book.samples
}

struct BooksListView: View {
    @StateObject fileprivate var viewModel = BooksViewModel()

    var body: some View {
        List(viewModel.books) { book in
            Text("\(book.title) by \(book.author)")
        }
    }
}

struct EditableBooksListView: View {
    @StateObject fileprivate var viewModel = BooksViewModel()

    var body: some View {
        List($viewModel.books) { $book in
            EditableBookRowView(book: $book)
        }
    }
}

private struct EditableBookRowView: View {
    @Binding var book: Book

    var body: some View {
        HStack(alignment: .top) {
//            Image($book.mediumCoverImageName)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(height: 90)
            VStack(alignment: .leading) {
                TextField("Book title", text: $book.title, prompt: Text("Enter the book title"))
                    .font(.headline)
                Text("by \(book.author)")
                    .font(.subheadline)
                Text("\(book.pages) pages")
                    .font(.subheadline)
            }
            Spacer()
        }
    }
}

#Preview {
    EditableBooksListView()
    // BooksListView()
}
