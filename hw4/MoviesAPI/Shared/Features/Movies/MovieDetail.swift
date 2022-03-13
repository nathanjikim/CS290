import SwiftUI

struct MovieDetail: View {
  @StateObject var viewModel: MovieDetailVM

  var body: some View {
      ScrollView {
        VStack {
          Text(viewModel.movie.title)
            .font(.largeTitle)
          Toggle(isOn: $viewModel.movie.viewed.animation(), label: { Text("I Viewed this movie")} )
            .onChange(of: viewModel.movie.viewed) { _ in viewModel.toggleSwitched() }
            .fixedSize()
          Button { viewModel.viewedButtonTapped() } label: { Text(viewModel.movie.viewed ? "Change to Unviewed" : "Change to Viewed") }

          VStack(alignment: .leading) {
            Text("Starring: ")
              .modifier(InfoSectionHeader())
            ForEach(viewModel.castMembers) { performer in
              Text(performer.name)
            }
            Text("Directed By: ")
              .modifier(InfoSectionHeader())
          }
          .padding(.top, 100)
        }
        .toolbar {
          ToolbarItem(placement: .primaryAction) { Button("Edit") { viewModel.editButtonTapped() } }
        }
        .sheet(isPresented: $viewModel.editSheetIsPresenting) { Text("Edit form to come!") }
      }
    
  }
}

struct MovieDetail_Previews: PreviewProvider {
  static let viewModel = MovieDetailVM(apiService: MovieAPIService(), movie: Movie.dummyData[0])
  static var previews: some View {
    MovieDetail(viewModel: viewModel)
  }
}
