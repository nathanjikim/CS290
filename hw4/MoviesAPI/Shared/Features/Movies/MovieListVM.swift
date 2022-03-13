import Foundation
import Combine

enum LoadingState {
  case notAvailable
  case loading
  case success
  case failed(error: Error)
}

@MainActor
class MovieListVM: ObservableObject {
  let apiService: MovieAPIService
  
  @Published private(set) var state: LoadingState = .notAvailable
  @Published var hasAPIError: Bool = false
  
  @Published var movies: [Movie] = []
  @Published var searchText: String = ""

  var filteredMovies: [Movie] {
    if searchText.isEmpty {
      return movies
    } else {
      return movies
        .filter { $0.searchableString.lowercased().contains(searchText.lowercased()) }
    }
  }

  init(apiService: MovieAPIService) {
    self.apiService = apiService
  }

  func getMovies() async {
    self.state = .loading
    do {
      let movies = try await apiService.fetch()
      self.state = .success
      self.movies = movies
    } catch {
      self.state = .failed(error: error)
      self.hasAPIError = true
    }
  }
  
  func deleteMovie(_ movie: Movie) {
    _ = try? apiService.deleteMovie(movie)
  }
  
}
