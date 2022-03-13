import SwiftUI

struct PerformerList: View {
  @StateObject var viewModel = PerformerListVM()

  var body: some View {
    List(viewModel.filteredPerformers) { performer in
      PerformerRow(viewModel: viewModel, performer: performer)
    }
    .searchable(text: $viewModel.searchText)
    .navigationTitle("Performers")
  }
}

struct PerformerRow: View {
  @ObservedObject var viewModel: PerformerListVM
  let performer: Performer

  var body: some View {
    VStack(alignment: .leading) {
      Text(performer.name)
      if let movieList = viewModel.movieListFor(performer: performer) {
        Text(movieList)
          .font(.footnote)
          .fontWeight(.bold)
      }
      Text(viewModel.birthdayText(for: performer))
        .font(.caption)
    }
  }
}

struct PerformerList_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      PerformerList()
    }
  }
}
