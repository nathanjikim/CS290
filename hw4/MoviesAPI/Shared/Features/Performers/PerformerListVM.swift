import Combine
import Foundation

class PerformerListVM: ObservableObject {
  // The performer list is not editing or changing any data. These can currently be lets, not @Published
  let performers = Performer.sortedDummyData
  let movies = Movie.sortedDummyData
  @Published var searchText = ""

  // Wait, why isn't this a published property?
  var filteredPerformers: [Performer] {
    if searchText.isEmpty {
      return performers
    } else {
      return performers
        .filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
  }

  func birthdayText(for performer: Performer) -> String {
    if let daysUntil = daysUntilBirthday(birthDate: performer.birthDate) {
      return "🎉 \(daysUntil) days"
    } else {
      return "no birthday"
    }
  }

  func movieListFor(performer: Performer) -> String? {
    let movies = movieCastingsFor(performer: performer)
    guard !movies.isEmpty else { return nil }

    return movies
      .map { $0.title }
      .joined(separator: ", ")
  }

  func movieCastingsFor(performer: Performer) -> [Movie] {
    movies
      .filter {
        $0.performers.contains(performer)
      }
  }

  func daysUntilBirthday(birthDate: Date?) -> Int? {
    guard let birthDate = birthDate else { return nil }

    var birthdayDateComponents = Calendar.current.dateComponents([.month, .day], from: birthDate)
    let todayDateComponents = Calendar.current.dateComponents([.month, .day, .year], from: Date.now)
    birthdayDateComponents.year = todayDateComponents.year
    var futureBirthday = Calendar.current.date(from: birthdayDateComponents)

    if let maybeAlreadyHappenedBirthday = futureBirthday,
       maybeAlreadyHappenedBirthday < Date.now,
       let year = todayDateComponents.year {
      birthdayDateComponents.year = (year + 1)
      futureBirthday = Calendar.current.date(from:birthdayDateComponents)
    }

    if let futureBirthday = futureBirthday {
      return Calendar.current.dateComponents([.day], from: Date.now, to: futureBirthday).day
    } else {
      return nil
    }
  }
  
}
