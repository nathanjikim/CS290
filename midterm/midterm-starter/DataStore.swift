import Foundation

class DataStore: ObservableObject {
  @Published var books = Book.previewData
  @Published var readingList: [Book] = []

  func addBookToReadingList(_ book: Book) {
    if readingList.firstIndex(where: { $0.id == book.id }) == nil {
      readingList.append(book)
    }
  }

  func removeBookFromReadingList(_ book: Book) {
    if let index = readingList.firstIndex(where: { $0.id == book.id }) {
      readingList.remove(at: index)
    }
  }
}
