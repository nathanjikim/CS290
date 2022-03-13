import Foundation

struct MovieAPIService {

  func fetch() async throws -> [Movie] {
    let url = MoviesEndpoint.baseUrl
    let body = MoviesEndpoint.Query.movies.rawValue
    let responseData: MoviesEndpoint.ResponseData = try await GraphQLAPI().performRequest(url: url, body: body)
    return responseData.movies ?? []
  }

  func createMovie(_ movie: Movie) throws -> Movie {
    print("I AM TRYING TO CREATE")
    return movie
  }

  func updateMovie(_ movie: Movie) throws -> Movie {
    print("I AM TRYING TO UPDATE")
    return movie
  }

  func deleteMovie(_ movie: Movie) throws -> Movie {
    print("I AM TRYING TO DELETE")
    return movie
  }
}
