import UIKit
import SwiftUI
import Foundation

enum Tab {
  case books
  case readingList
}

struct TabContainer: View {
  @State var selectedTab: Tab = .books
    @StateObject var dataStore = DataStore()

  var body: some View {
    Group {
      TabView(selection: $selectedTab){

        NavigationView {
            BookList(viewModel: BookListVM(dataStore: dataStore))
        }
        .tabItem {
          Label("Books", systemImage: "book")
        }
        .tag(Tab.books)

        NavigationView {
            ReadingList(viewModel: ReadingListVM(dataStore:dataStore))
        }
        .tabItem {
          Label("Reading List", systemImage: "list.star")
        }
        .tag(Tab.readingList)

      }
    }
  }
}

//struct TabContainer_Previews: PreviewProvider {
//  static var previews: some View {
//      TabContainer(viewModel: BookListVM)
//  }
//}
