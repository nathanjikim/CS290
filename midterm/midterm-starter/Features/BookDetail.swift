//
//  BookDetail.swift
//  midterm
//
//  Created by Nathan Kim on 2/23/22.
//

import UIKit
import SwiftUI

struct BookDetail:View {
    @StateObject var viewModel: BookDetailVM

    var body: some View {
      Group {
        switch viewModel.state {
        case .loading:
          ProgressView()
        case .notAvailable:
          Text("Cannot reach API")
        case .failed:
            BookDetailNotLoaded(viewModel: viewModel)
        case .success(let summary):
            BookDetailLoaded(viewModel: viewModel, summary: summary)
        }
      }
      .task { await viewModel.getPlotSummary() }
      .alert("Error", isPresented: $viewModel.hasAPIError, presenting: viewModel.state) { detail in
          Button("Retry") {
            Task { await viewModel.getPlotSummary() }
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
struct BookDetailNotLoaded: View {
    @EnvironmentObject var dataStore: DataStore
    @StateObject var viewModel: BookDetailVM
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Image(systemName: "book")
                Text(viewModel.book.title)
                    .font(.largeTitle)
                    .padding(.bottom, 1)
                    .multilineTextAlignment(.center)
                Text(viewModel.book.author)
                Spacer()
                Spacer()
                Text("Could not load description")
                    .padding(.horizontal, 16)
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    switch viewModel.addOrRemove {
                    case true:
                        Button("Remove") {
                            viewModel.addOrRemove = false
                            viewModel.removeButtonTapped(book: viewModel.book)
                        }
                    case false:
                        Button("Add") {
                            viewModel.addOrRemove = true
                        viewModel.addButtonTapped(book: viewModel.book)
                    }
                    }}}
        }
    }
}
struct BookDetailLoaded: View {
    @EnvironmentObject var dataStore: DataStore
    @StateObject var viewModel: BookDetailVM
    let summary: String
    
    var body: some View {

            ScrollView {
                VStack(alignment: .center) {
                    AsyncImage(url: viewModel.book.coverUrl) { image in image
                            .resizable()
                    } placeholder: {
                        if $viewModel.book.coverUrl != nil {
                            ProgressView()
                        } else {
                            Image(systemName: "book")
                        }
                    }
                    .frame(maxWidth: 120, maxHeight: 200)
                    Text(viewModel.book.title)
                        .font(.largeTitle)
                        .padding(.bottom, 1)
                        .multilineTextAlignment(.center)
                    Text(viewModel.book.author)
                    Spacer()
                    Spacer()
                    Text(summary).padding(.horizontal, 16)
                    Spacer()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        switch viewModel.addOrRemove {
                        case true:
                            Button("Remove") {
                                viewModel.addOrRemove = false
                                viewModel.removeButtonTapped(book: viewModel.book)
                            }
                        case false:
                            Button("Add") {
                                viewModel.addOrRemove = true
                            viewModel.addButtonTapped(book: viewModel.book)
                        }
                        }}}
//
                
                
            
        }
    }
}


//struct BookDetail_Previews: PreviewProvider {
//  static let dataStore = DataStore()
//    static let viewModel = BookDetailVM(dataStore: dataStore, bookId: Book.previewData[0].id, apiService: OpenLibraryAPIService())
//  static var previews: some View {
//    BookDetail(viewModel: viewModel)
//  }
//}

