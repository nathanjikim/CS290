import Foundation

struct GraphQLEndpoint<ResponseData: Decodable> {
  struct Response: Decodable {
    let responseData: ResponseData?
    let responseError: [ResponseError]?

    private enum CodingKeys: String, CodingKey {
      case responseData = "data"
      case responseError = "errors"
    }

    struct ResponseError: Decodable {
      let message: String?
      let details: String?
    }
  }
}
