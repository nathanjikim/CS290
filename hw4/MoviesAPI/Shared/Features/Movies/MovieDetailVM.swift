import Foundation
import Combine

class MovieDetailVM: ObservableObject {
  let apiService: MovieAPIService
  @Published var movie: Movie
  @Published var editSheetIsPresenting: Bool = false

  init(apiService: MovieAPIService, movie: Movie) {
    self.apiService = apiService
    self.movie = movie
  }

  var castMembers: [Performer] {
    movie.performers.sorted { $0.sortableName < $1.sortableName }
  }

  func editButtonTapped() {
    self.editSheetIsPresenting = true
  }

  func viewedButtonTapped() {
    movie.viewed = (movie.viewed ? false : true)
    saveMovie()
  }

  func toggleSwitched() {
    saveMovie()
  }

  func saveMovie() {
    _ = try? apiService.updateMovie(movie)
  }
}
