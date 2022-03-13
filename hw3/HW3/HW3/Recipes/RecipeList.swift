//
//  RecipeList.swift
//  HW2
//
//  Created by Nathan Kim on 1/30/22.
//
//  WORKED WITH VIRAAJ PUNIA CHECK README

import UIKit
import SwiftUI
import Foundation

struct RecipeList: View {
    @EnvironmentObject var recipeStore: RecipeStore
    @StateObject var viewModel: RecipeListVM
    
    var body: some View {
        NavigationView {
            List(viewModel.filteredRecipes)
            { recipe in
                NavigationLink(destination:
                                RecipeDetail(viewModel: RecipeDetailVM(recipeStore: recipeStore, recipeId: recipe.id))) {
                    RecipeRow(recipe: recipe)
                }
            }.navigationTitle("Recipes - njk24")
                .searchable(text: $viewModel.searchText)
        }
    }
}

struct RecipeRow: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            AsyncImage(url: recipe.thumbnailUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(6)
                    .frame(maxWidth: 100, maxHeight: 100)
            } placeholder: {
                if recipe.thumbnailUrl != nil {
                    ProgressView()
                } else {
                    Image(systemName: "film.fill")
                }
            }
            .frame(maxWidth: 100, maxHeight: 100)
            VStack(alignment: .leading) {
                Text(recipe.mealCourse.rawValue)
                Text(recipe.name).bold().fixedSize(horizontal: false, vertical: true)
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(recipe.tags, id: \.self) { index in
                            TagView(label: "\(index)")
                        }.padding(3)
                    }.padding()
                }
            }
            Image(systemName: (recipe.lastPreparedAt != nil) ? "checkmark.circle.fill" : "circle").foregroundColor((recipe.lastPreparedAt != nil) ? Color.red : Color.black)
        }
    }
}





struct RecipeList_Previews: PreviewProvider {
    static let recipeStore = RecipeStore()
    static var previews: some View {
      RecipeList(viewModel: RecipeListVM(recipeStore: recipeStore))
    }
}

