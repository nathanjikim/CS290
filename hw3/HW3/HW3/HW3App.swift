//
//  HW3App.swift
//  HW3
//
//  Created by Nathan Kim on 2/6/22.
//



import SwiftUI

@main
struct HW3App: App {
  @StateObject var recipeStore = RecipeStore()

    var body: some Scene {
        WindowGroup {
            RecipeList(viewModel:RecipeListVM(recipeStore: recipeStore))
                .environmentObject(recipeStore)
        }
    }
}
