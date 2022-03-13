import SwiftUI

@main
struct Movies_Wk4App: App {

  var body: some Scene {
    WindowGroup {
      NavigationView {
        MovieScreen(viewModel: MovieListVM(apiService: MovieAPIService()))
      }
    }
  }
}
