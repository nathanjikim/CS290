import Foundation

protocol GraphQLResponse {
  
}

struct MovieEndpoint {
  static let baseUrl = "http://localhost:4000/api"

  enum Query: String {
    case movies = "query { movies { id title genre posterUrl performers { id name birthDate }}}"
  }

  struct Result: Codable {
    let results: [Movie]
  }

  struct Response: Decodable {
    let responseData: ResponseData?
    let responseError: [ResponseError]?

    private enum CodingKeys: String, CodingKey {
      case responseData = "data"
      case responseError = "errors"
    }

    struct ResponseData: Decodable {
      let movies: [Movie]?
    }

    struct ResponseError: Decodable {
      let message: String?
      let details: String?
    }
  }

}
