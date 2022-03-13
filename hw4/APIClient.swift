import Foundation

protocol APIClient {
  var session: URLSession { get }
}

extension APIClient {

  func perform<ResponseType:Decodable>(request: URLRequest) async throws -> ResponseType {
    let (data, response) = try await session.data(for: request)
    guard let http = response as? HTTPURLResponse else { throw APIError.invalidResponse }
    guard http.statusCode == 200 else {
      switch http.statusCode {
      case 400...499:
        let body = String(data: data, encoding: .utf8)
        throw APIError.requestError(http.statusCode, body ?? "<no body>")
      case 500...599:
        throw APIError.serverError
      default: throw APIError.invalidStatusCode("\(http.statusCode)")
      }
    }
    do {
      let jsonDecoder = JSONDecoder()
      jsonDecoder.dateDecodingStrategy = .iso8601
      return try jsonDecoder.decode(ResponseType.self, from: data)
    } catch let decodingError as DecodingError {
      throw APIError.decodingError(decodingError)
    }
  }
}
