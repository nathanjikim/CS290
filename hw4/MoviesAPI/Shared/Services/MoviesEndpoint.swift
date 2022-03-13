import Foundation

struct MoviesEndpoint {
  static let baseUrl = "https://learning-swift.gigalixirapp.com/api"
  //static let baseUrl = "http://localhost:4000/api"

  
  enum Query: String {
    case movies = """
      query { movies { id title genre viewed posterUrl
                        performers { name id }
      }}
    """
  }

  struct ResponseData: Decodable {
    let movies: [Movie]?
  }
  
}
