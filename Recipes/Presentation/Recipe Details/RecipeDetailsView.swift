//
//  RecipeDetailsView.swift
//  Recipes
//
//  Created by Dylan on 4/7/25.
//

import SwiftUI
import Kingfisher
import YouTubePlayerKit

struct RecipeDetailsView: View {
    @Environment(\.dismiss) private var dismiss
    let recipe: Recipe
    @State private var viewModel: RecipeDetailsViewModel
    @State private var isVideoPlayerSheetPresented: Bool = false
    init(recipe: Recipe, recipeRepository: RecipeRepository) {
        self.recipe = recipe
        _viewModel = State(initialValue: RecipeDetailsViewModel(recipeId: recipe.id, recipeRepository: recipeRepository))
    }
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
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "bookmark")
                        .frame(width: 40.0, height: 40.0)
                        .background {
                            Circle()
                                .fill(.regularMaterial)
    
                        }
                }
            }
        }
        .sheet(isPresented: $isVideoPlayerSheetPresented) {
            if case .success(let recipeDetails) = viewModel.recipeDetailsDataState, let youtubeVideoLink = recipeDetails.youtube, let url = URL(string: youtubeVideoLink) {
                YouTubePlayerView(YouTubePlayer(url: url))
                    .ignoresSafeArea()
                    .presentationDetents([.medium])
            }
        }
        .task {
            await viewModel.getRecipeDetails()
        }
    }
    private var recipeImageView: some View {
        KFImage(URL(string: recipe.image))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxHeight: 360.0)
            .clipped()
            .overlay {
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
            Text(recipe.name)
                .font(.title)
                .fontWeight(.semibold)
            if case .success(let recipeDetails) = viewModel.recipeDetailsDataState {
                HStack {
                    HStack {
                        Image(systemName: "fork.knife")
                            .foregroundStyle(.accent)
                        Text(recipeDetails.category ?? "unavailable.")
                    }
                    Spacer()
                    HStack {
                        Image(systemName: "pin.fill")
                            .foregroundStyle(.accent)
                        Text(recipeDetails.area ?? "unavailable.")
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16.0)
    }
    @ViewBuilder
    private var recipeDetailsView: some View {
        switch viewModel.recipeDetailsDataState {
        case .idle:
            EmptyView()
        case .loading:
            ProgressView()
        case .success(let recipeDetails):
            Group {
                recipeTagsView(
                    recipeDetails.tags ?? "unavailable."
                )
                recipeInstructionsView(
                    recipeDetails.instructions ?? "unavailable."
                )
                recipeIngredientsView
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16.0)
        case .failure(let equatableError):
            ErrorView(error: equatableError.error)
        }
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
                    ForEach(viewModel.ingredients) { ingredient in
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
}

#Preview {
    NavigationStack {
        RecipeDetailsView(
            recipe: Recipe.sample,
            recipeRepository: RemoteRecipeCategory(apiService: MealsDbApiService())
        )
    }
}
