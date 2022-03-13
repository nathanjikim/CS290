//
//  BookListVM.swift
//  midterm
//
//  Created by Nathan Kim on 2/21/22.
//
import Foundation
import Combine
import SwiftUI

class BookListVM: ObservableObject {
    let dataStore: DataStore
    var cancellables: Set<AnyCancellable> = []
    
    @Published var books: [Book] = []
    @Published var searchText: String = ""
    
    var filteredBooks: [Book] {
        if searchText.isEmpty {
            return books
        } else {
            return books.filter({ $0.title.lowercased().contains(searchText.lowercased())})
        }
    }
    
    init(dataStore: DataStore) {
        self.dataStore = dataStore
        dataStore.$books
            .sink{ [weak self] recipesPublishedFromStore in
                self?.books = recipesPublishedFromStore
            }
            .store(in: &cancellables)
    }
    
    func deleteBook(_ book: Book) {
        dataStore.removeBookFromReadingList(book)
    }
    
}
