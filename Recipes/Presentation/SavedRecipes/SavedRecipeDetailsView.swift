//
//  SavedRecipeDetailsView.swift
//  Recipes
//
//  Created by Dylan on 16/8/25.
//

import SwiftUI
import Kingfisher
import YouTubePlayerKit

struct SavedRecipeDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    let savedRecipe: SavedRecipe
    @State private var isVideoPlayerSheetPresented: Bool = false
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20.0) {
                recipeImageView
                recipeInfoView
                recipeDetailsView
            }
        }
        .scrollIndicators(.hidden)
        .contentMargins(.bottom, 16.0)
        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden()
        .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .frame(width: 40.0, height: 40.0)
                        .background {
                            Circle()
                                .fill(.regularMaterial)
                        }
                }
            }
        }
        .sheet(isPresented: $isVideoPlayerSheetPresented) {
            if let youtubeVideoLink = savedRecipe.youtube, let url = URL(string: youtubeVideoLink) {
                YouTubePlayerView(YouTubePlayer(url: url))
                    .ignoresSafeArea()
                    .presentationDetents([.medium])
            }
        }
    }
    private var recipeImageView: some View {
        ZStack {
            if let image = savedRecipe.image {
                KFImage(URL(string: image))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxHeight: 360.0)
                    .clipped()
            } else {
                Rectangle()
                    .fill(Color(uiColor: .systemGray6))
                    .frame(height: 360.0)
            }
            Button {
                isVideoPlayerSheetPresented.toggle()
            } label: {
                Image(systemName: "play.rectangle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .frame(width: 80.0, height: 80.0)
                    .foregroundStyle(.pink.gradient)
                    .background {
                        Circle()
                            .fill(.thinMaterial)
                    }
            }
            .buttonStyle(.plain)
        }
    }
    private var recipeInfoView: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            Text(savedRecipe.name ?? "Unknown")
                .font(.title)
                .fontWeight(.semibold)
            HStack {
                HStack {
                    Image(systemName: "fork.knife")
                        .foregroundStyle(.accent.gradient)
                    Text(savedRecipe.category ?? "unavailable.")
                }
                Spacer()
                HStack {
                    Image(systemName: "pin.fill")
                        .foregroundStyle(.accent.gradient)
                    Text(savedRecipe.area ?? "unavailable.")
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16.0)
    }
    @ViewBuilder
    private var recipeDetailsView: some View {
        Group {
            recipeTagsView(
                savedRecipe.tags ?? "unavailable."
            )
            recipeInstructionsView(
                savedRecipe.instructions ?? "unavailable."
            )
            recipeIngredientsView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16.0)
    }
    private func recipeTagsView(_ tags: String) -> some View {
        VStack(alignment: .leading, spacing: 12.0) {
            HStack {
                Image(.hashTag)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32.0, height: 32.0)
                    .foregroundStyle(.mint.gradient)
                Text("Tags")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            Text(tags)
        }
    }
    private func recipeInstructionsView(_ instructions: String) -> some View {
        VStack(alignment: .leading, spacing: 12.0) {
            HStack {
                Image(.chefHat)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32.0, height: 32.0)
                    .foregroundStyle(.green.gradient)
                Text("Instructions")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            Text(instructions)
        }
    }
    var recipeIngredientsView: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            HStack {
                Image(.menu)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32.0, height: 32.0)
                    .foregroundStyle(.indigo.gradient)
                Text("Ingredients")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            GroupBox {
                VStack(spacing: 8.0) {
                    ForEach(ingredients) { ingredient in
                        ingredientItemView(ingredient)
                    }
                }
            }
        }
    }
    func ingredientItemView(_ ingredient: Ingredient) -> some View {
        HStack {
            Text(ingredient.name)
            Spacer()
            Text(ingredient.measure)
                .fontWeight(.medium)
        }
    }
    private var ingredients: [Ingredient] {
        var ingredients: [Ingredient] = []
        let mirror = Mirror(reflecting: savedRecipe.toRecipeDetails())
        for (label, value) in mirror.children {
            if let label, label.starts(with: "ingredient"), let ingredientName = value as? String, !ingredientName.isEmpty {
                let ingredientNo = label.dropFirst("ingredient".count)
                if let measure = mirror.descendant("measure\(ingredientNo)") as? String {
                    let ingredient = Ingredient(name: ingredientName, measure: measure)
                    ingredients.append(ingredient)
                }
            }
        }
        return ingredients
    }
}
