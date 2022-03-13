import Foundation

struct Performer: Identifiable, Equatable, Codable {
  var id: UUID = UUID()
  var name: String
  var birthDate: Date?

  var sortableName: String {
    name
      .split(separator: " ")
      .map(String.init)
      .reversed()
      .joined(separator: ", ")
  }
  
}

extension Performer {
  static let sortedDummyData = dummyData.sorted { $0.sortableName < $1.sortableName }
  static let dummyData = [awkwafina, bacon, chalamet, cumberbatch, elba, holland, king, ronan, zendaya]

  static func birthDate(_ date: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"
    return formatter.date(from: date)!
  }

  static let awkwafina = Performer(name: "Awkwafina", birthDate: birthDate("06/02/1988"))
  static let bacon = Performer(name: "Kevin Bacon", birthDate: nil)
  static let chalamet = Performer(name: "Timothée Chalamet", birthDate: birthDate("12/27/1995"))
  static let cumberbatch = Performer(name: "Benedict Cumberbatch", birthDate: birthDate("07/19/1976"))
  static let elba = Performer(name: "Idris Elba", birthDate: birthDate("09/06/1972"))
  static let holland = Performer(name: "Tom Holland", birthDate: birthDate("06/01/1996"))
  static let king = Performer(name: "Regina King", birthDate: birthDate("01/15/1971"))
  static let ronan = Performer(name: "Saoirse Ronan", birthDate: birthDate("04/12/1994"))
  static let zendaya = Performer(name: "Zendaya", birthDate: birthDate("09/01/1996"))
}
