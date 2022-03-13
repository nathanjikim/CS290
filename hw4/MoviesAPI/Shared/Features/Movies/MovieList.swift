import SwiftUI

struct MovieScreen: View {
  @StateObject var viewModel: MovieListVM

  var body: some View {
    Group {
      switch viewModel.state {
      case .loading:
        ProgressView()
      case .notAvailable:
        Text("Cannot reach API")
      case .failed:
        Text("Error")
      case .success:
        MovieList(viewModel: viewModel)
      }
    }
    .task { await viewModel.getMovies() }
    .alert("Error", isPresented: $viewModel.hasAPIError, presenting: viewModel.state) { detail in
        Button("Retry") {
          Task { await viewModel.getMovies() }
        }
        Button("Cancel") {}
      }
      message: { detail in
        if case let .failed(error) = detail {
          Text(error.localizedDescription)
        }
      }
  }
}

struct MovieList: View {
  @ObservedObject var viewModel: MovieListVM

  var body: some View {
    List(viewModel.filteredMovies) { movie in
      NavigationLink(destination: MovieDetail(
        viewModel: MovieDetailVM(apiService: MovieAPIService(), movie: movie)
      )) {
        MovieRow(movie: movie)
      }
      .swipeActions(edge: .trailing) {
        Button(role: .destructive) {
          viewModel.deleteMovie(movie)
        } label: {
          Label("Delete", systemImage: "trash")
        }
      }
    }
    .navigationTitle("Movies - jrp96")
    .searchable(text: $viewModel.searchText)
  }
}

struct MovieRow: View {
  let movie: Movie

  var body: some View {
    HStack {
      AsyncImage(url: movie.posterUrl) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fit)
      } placeholder: {
        if movie.posterUrl != nil {
          ProgressView()
        } else {
          Image(systemName: "film.fill")
        }
      }
      .frame(maxWidth: 100, maxHeight: 100)
      Text(movie.title)
      Spacer()
      Image(systemName: movie.viewed ? "checkmark.circle.fill" : "circle")
        .foregroundColor(movie.viewed ? Color.green : Color.black)
    }
  }
}


struct MovieList_Previews: PreviewProvider {
  static var previews: some View {
    MovieList(viewModel: MovieListVM(apiService: MovieAPIService()))
  }
}
