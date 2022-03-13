//
//  OpenLibraryEndpoint.swift
//  midterm
//
//  Created by Nathan Kim on 2/21/22.
//

import Foundation
struct BooksEndpoint {
    let dataStore: DataStore
    var books: [Book] = []
    static let baseUrl = "https://openlibrary.org/works/" 
    
    //static let baseUrl = "http://localhost:4000/api"

//    enum Query: String {
//        case books = """
//        query { recipes
//        { id title author coverUrl { position OpenLibraryResponse }
//        }
//        }
//        """
//    }
    struct ResponseData: Decodable {
        let books: [Book]?
    }
}
