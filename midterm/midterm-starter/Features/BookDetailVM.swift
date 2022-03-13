//
//  BookDetailVM.swift
//  midterm
//
//  Created by Nathan Kim on 2/23/22.
//
import Foundation
import Combine

enum LoadedState {
    case notAvailable
    case loading
    case success(summary: String)
    case failed(error: Error)
}
@MainActor
class BookDetailVM: ObservableObject {
//    enum State {
//        case loading
//        case loaded
//    }
    private var dataStore: DataStore
    private var cancellables: Set<AnyCancellable> = []
    var bookId: Book.ID
    let apiService: OpenLibraryAPIService
    @Published private(set) var state: LoadedState = .notAvailable
    @Published var hasAPIError: Bool = false
    @Published var book: Book = Book(id: "none", title: "Loading", author: "Loading")
    @Published var books: [Book] = []
    @Published var editSheetIsPresenting: Bool = false
    @Published var addOrRemove: Bool = false
    @Published var readinglist: [Book] = []

    init(dataStore: DataStore, bookId: String, apiService: OpenLibraryAPIService, book: Book) {
        self.dataStore = dataStore
        self.bookId = bookId
        self.book = book
        self.apiService = apiService
        dataStore.$books
            .sink{ [weak self] storeBooks in
                if let book = storeBooks.filter({ $0.id == self?.bookId}).first {
                    self?.book = book
                    self?.state = .loading
                }
            }
            .store(in: &cancellables)
        dataStore.$readingList
            .sink{ [weak self] booksToRead in
                if booksToRead.contains(where: { $0.id == self?.book.id }) {
                    self?.readinglist.append(book)
                    self?.addOrRemove = true
                }
                else {
                    self?.addOrRemove = false
                }
            }
            .store(in: &cancellables)
    }
    func editButtonTapped() {
        self.editSheetIsPresenting = true
    }
    func editButtonBegone() {
        self.editSheetIsPresenting = false
    }
    func getPlotSummary() async {
        self.state = .loading
        do {
            let response: OpenLibraryResponse = try await apiService.fetch(bookId: self.bookId )
            let summary = response.summaryContainer.summary
            self.state = .success(summary: summary)
        } catch {
            self.state = .failed(error: error)
            self.hasAPIError = true
        }
    }
    func addButtonTapped(book: Book) {
      dataStore.addBookToReadingList(book)
    }

    func removeButtonTapped(book: Book) {
      dataStore.removeBookFromReadingList(book)
    }
    
}
