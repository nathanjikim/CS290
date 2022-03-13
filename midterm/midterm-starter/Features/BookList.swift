import UIKit
import SwiftUI
import Foundation

struct BookList: View {
    @EnvironmentObject var dataStore: DataStore
    @StateObject var viewModel: BookListVM
    
    var body: some View {

            List(viewModel.books)
            { book in
                NavigationLink(destination:
                                BookDetail(viewModel: BookDetailVM(dataStore: viewModel.dataStore, bookId: book.id, apiService: OpenLibraryAPIService(),book: book))) {
                    BookRow(book: book)
                }
            }
        .navigationTitle("Books - njk24")
    }
}

struct BookRow: View {
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

struct BookList_Previews: PreviewProvider {
    static let dataStore = DataStore()
    static var previews: some View {
        BookList(viewModel: BookListVM(dataStore: dataStore))
    }
}



