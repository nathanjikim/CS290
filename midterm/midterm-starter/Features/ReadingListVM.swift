//
//  ReadingListVM.swift
//  midterm
//
//  Created by Nathan Kim on 2/21/22.
//
import UIKit
import SwiftUI
import Foundation
import Combine

class ReadingListVM: ObservableObject {
    let dataStore: DataStore
    var cancellables: Set<AnyCancellable> = []
    @Published var readinglist: [Book] = []
    
    init(dataStore: DataStore) {
        self.dataStore = dataStore
        dataStore.$readingList
            .sink{ [weak self] booksToRead in
                self?.readinglist = booksToRead
            }
            .store(in: &cancellables)
    }
    
    func deleteBookAgain(_ book: Book) {
        dataStore.removeBookFromReadingList(book)
    }
}
