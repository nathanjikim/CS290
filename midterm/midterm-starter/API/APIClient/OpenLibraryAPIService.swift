//
//  OpenLibraryAPIService.swift
//  midterm
//
//  Created by Nathan Kim on 2/21/22.
//

import Foundation

struct OpenLibraryAPIService {
    func fetch(bookId: String) async throws -> OpenLibraryResponse {
        let url = BooksEndpoint.baseUrl
//        let body = BooksEndpoint.Query.books.rawValue
        let stringed = url + bookId + ".json"
        let responseData: OpenLibraryResponse = try await RestAPIClient().performRequest(url: stringed)
        return responseData
    }
    func updateBook(_ book: Book) {
        print("Simulating Update Book")
    }
    
    func deleteBook(_ book: Book) {
        print("Simulating Delete Book")
    }
}
