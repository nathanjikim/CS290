import Foundation

struct GraphQLAPI: APIClient {
  let session: URLSession = .shared

  func performRequest<ResponseData: Decodable>(url: String, body: String) async throws -> ResponseData {
    guard let url = URL(string: url) else { throw APIError.invalidUrl(url) }
    var request = URLRequest(url: url)
    request.httpBody = body.data(using: .utf8)
    request.httpMethod = "post"
    request.setValue("application/graphql", forHTTPHeaderField: "Content-Type")

    let response: GraphQLEndpoint<ResponseData>.Response = try await perform(request: request)
    if let error = response.responseError?.first { throw GraphQLError.queryError("\(error.message ?? "") details: \(error.details ?? "")") }
    guard let responseData = response.responseData else { throw GraphQLError.noData}
    return responseData
  }
}

enum GraphQLError: LocalizedError {
  case queryError(String)
  case noData

  var errorDescription: String? {
    switch self {
    case .queryError(let message): return "GraphQL query error: \(message)"
    case .noData: return "GraphQL Error: no data"
    }
  }

  var recoverySuggestion: String? {
    switch self {
    case .queryError:
      return "Please fix the query."
    case .noData: return "Unknown solution"
    }
  }
}
