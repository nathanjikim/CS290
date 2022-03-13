import Foundation

struct OpenLibraryResponse: Decodable {
  var summaryContainer: OpenLibrarySummaryContainer

  enum CodingKeys: String, CodingKey {
    case summaryContainer = "description"
  }
}

struct OpenLibrarySummaryContainer: Decodable {
  var summary: String

  enum CodingKeys: String, CodingKey {
    case summary = "value"
  }
}
