//
//  RecipeDetail.swift
//  HW2
//
//  Created by Nathan Kim on 1/30/22.
//


import UIKit
import SwiftUI


struct RecipeDetail: View {
    @StateObject var viewModel: RecipeDetailVM
    
    var body: some View {
        switch viewModel.state {
        case .loading: ProgressView()
        case .loaded:
        ScrollView {
            VStack(alignment: .center) {
                AsyncImage(url: viewModel.recipe.thumbnailUrl) { image in image
                        .resizable()
                } placeholder: {
                    if $viewModel.recipe.thumbnailUrl != nil {
                        ProgressView()
                    } else {
                        Image(systemName: "film.fill")
                    }
                }
                .frame(maxWidth: 250, maxHeight: 200)
                .cornerRadius(6)
                Text(viewModel.recipe.name)
                    .font(.largeTitle)
                    .padding(.bottom, 1)
                    .multilineTextAlignment(.center)
                Button{ viewModel.recipe.lastPreparedAt = ((self.viewModel.recipe.lastPreparedAt != nil) ? nil : Date.now); viewModel.preparedButtonTapped() } label: {Text((viewModel.recipe.lastPreparedAt != nil) ? "I haven't prepared it yet!" : "I've already prepared it!") }
                Spacer()
                Spacer()
                Spacer()
                VStack(alignment: .center) {
                    Text("Ingredients").fontWeight(.bold)
                        .background(RoundedRectangle(cornerRadius: 24).foregroundColor(Color.orange).padding(-6))
                    Spacer()
                    ForEach(viewModel.recipe.componentSections ?? [""], id: \.self) { sectionLabel in
                      Text(sectionLabel)
                        .bold()
                        .padding(.top, 6)
                        ForEach(viewModel.recipe.componentsForSection(sectionLabel: sectionLabel), id: \.self) { component in
                            Text(componentDisplay(component, recipe: viewModel.recipe))
                      }
                    }
                    ForEach(viewModel.recipe.unsectionedComponents) { component in
                        Text(componentDisplay(component, recipe: viewModel.recipe))
                    }
                    Spacer()
                    Spacer()
                    Text("Instructions").fontWeight(.bold)
                        .background(RoundedRectangle(cornerRadius: 24).foregroundColor(Color.orange).padding(-6))
                    let instructions: [Instruction] = viewModel.recipe.instructions
                    VStack(alignment: .leading) {
                        ForEach(Array(instructions), id :\.instructionText) { instruction in Text(instruction.instructionText).padding(.horizontal, 16) .padding(.vertical, 10)}
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){ Button("Edit") {
                    viewModel.editButtonTapped()}}}
            .sheet(isPresented: $viewModel.editSheetIsPresenting) {
                VStack {
                NavigationView{
                    VStack {
                    Text("Need to feed more people? Scale recipe ingredients to serving size needed!")
                        .multilineTextAlignment(.center)
                    Picker("Scale", selection: $viewModel.recipe.scaleValue) {
                        Text("1x").tag(1.0)
                            Text("1 1/4x").tag(1.25)
                            Text("1 1/2x").tag(1.5)
                            Text("1 3/4x").tag(1.75)
                        Text("2x").tag(2.0)
                        }.pickerStyle(.segmented)
                            .padding(.horizontal, 25)

                    }
                    .padding(.bottom, 210)
                        .toolbar {Button(action: {
                            viewModel.editButtonBegone()}) {
                        Text("Done").bold()
                        }
                            
                        }
                        .navigationTitle("Edit Scale")
                }
 
                   
                }
                    
                
            
            }
            }
        }
    }
}
func componentDisplay(_ recipeComponent: RecipeComponent, recipe: Recipe) -> String {
  [
    recipeComponent.quantity.map { String($0 * recipe.scaleValue) } ?? "",
    recipeComponent.unit.map { String($0) } ?? "",
    recipeComponent.ingredient.name
  ]
    .filter { !$0.isEmpty }
    .joined(separator: " ")
}

struct RecipeDetail_Previews: PreviewProvider {
  static let recipeStore = RecipeStore()
  static let viewModel = RecipeDetailVM(recipeStore: recipeStore, recipeId: Recipe.previewData[0].id)
  static var previews: some View {
    RecipeDetail(viewModel: viewModel)
  }
}

