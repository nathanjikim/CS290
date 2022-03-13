import UIKit
import SwiftUI
import Foundation

struct ReadingList: View {
    @EnvironmentObject var dataStore: DataStore
    @StateObject var viewModel: ReadingListVM
    
    var body: some View {

        List(viewModel.dataStore.readingList)
            { book in
                    BookRow(book: book)
                    .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) { viewModel.deleteBookAgain(book) } label: {
                                    Label("Delete", systemImage: "trash")
                                  }
                                }
            }
            .navigationTitle("Reading List")
    }
}

struct ReadingRow: View {
    let book: Book
    
    var body: some View {
        HStack {
            AsyncImage(url: book.coverUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 60, maxHeight: 60)
            } placeholder: {
                if book.coverUrl != nil {
                    ProgressView()
                } else {
                    Image(systemName: "book")
                }
            }
            .frame(maxWidth: 60, maxHeight: 60)
            VStack(alignment: .leading) {
                Text(book.title).bold().fixedSize(horizontal: false, vertical: true)
                Text(book.author)
            }
        }
    }
}
