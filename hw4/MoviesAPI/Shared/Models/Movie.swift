import Foundation

struct Movie: Identifiable, Codable {
  var id: Int
  var title: String
  var genre: Genre
  var performers: [Performer] = []
  var viewed: Bool = false
  var posterUrl: URL?

  var sortableTitle: String {
    self.title.prefix(4) == "The " ? String(self.title.dropFirst(4)) : self.title
  }
  var searchableString: String {
    "\(title) \(performers.map { $0.name }.joined(separator: " "))".lowercased()
  }

}

extension Movie {
  enum Genre: String, Codable {
    case action
    case comedy
    case drama
    case sff
    case western
  }
}

extension Movie {
  static let sortedDummyData = dummyData.sorted { $0.sortableTitle < $1.sortableTitle }
  static let dummyData = [
    Movie(id: 1, title: "The Power of the Dog", genre: .drama, performers: [.cumberbatch], posterUrl: PU.powerUrl),
    Movie(id: 2, title: "Dune", genre: .sff, performers: [.chalamet, .zendaya], posterUrl: PU.duneUrl),
    Movie(id: 3, title: "Little Women", genre: .drama, performers: [.ronan, .chalamet], posterUrl: PU.littleUrl),
    Movie(id: 4, title: "The Harder They Fall", genre: .western, performers: [.elba, .king], posterUrl: PU.harderUrl),
    Movie(id: 5, title: "Spider-Man: No Way Home", genre: .sff, performers: [.zendaya, .holland], posterUrl: PU.spiderUrl),
    Movie(id: 6, title: "The Farewell", genre: .drama, performers: [.awkwafina], posterUrl: PU.farewellUrl)
  ]
}

// This is silly; no one would ever do it like this. PU = "Poster Url"
// I'm shoving these "constants" here to make the above dummyData creation easier to read
struct PU {
  static let powerUrl = URL(string: "https://education-jrp.s3.amazonaws.com/MovieImages/ThePowerOfTheDog.jpeg")
  static let duneUrl = URL(string: "https://education-jrp.s3.amazonaws.com/MovieImages/Dune.jpeg")
  static let littleUrl = URL(string: "https://education-jrp.s3.amazonaws.com/MovieImages/LittleWomen.jpeg")
  static let harderUrl = URL(string: "https://education-jrp.s3.amazonaws.com/MovieImages/TheHarderTheyFall.jpeg")
  static let spiderUrl = URL(string: "https://education-jrp.s3.amazonaws.com/MovieImages/SpiderMan.jpeg")
  static let farewellUrl = URL(string: "https://education-jrp.s3.amazonaws.com/MovieImages/TheFarewell.jpeg")
}






