//
//  SearchView.swift
//  Recipes
//
//  Created by Dylan on 5/7/25.
//

import SwiftUI
import SwiftUINavigationTransitions

struct SearchView: View {
    let recipeRepository: RecipeRepository
    @State private var viewModel: SearchViewModel
    init(recipeRepository: RecipeRepository) {
        self.recipeRepository = recipeRepository
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor : UIColor.accent,
        ]
        _viewModel = State(initialValue: SearchViewModel(recipeRepository: recipeRepository))
    }
    var body: some View {
        VStack(spacing: 4.0) {
            searchBarView
            searchResultsView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Recipe.self) { recipe in
            RecipeDetailsView(recipe: recipe, recipeRepository: recipeRepository)
        }
        .navigationTransition(
            .slide(axis: .horizontal).combined(with: .fade(.in)),
            interactivity: .pan
        )
        .onChange(of: viewModel.searchText) {
            if case .success(let searchResults) = viewModel.searchResultsDataState, searchResults.isEmpty {
                viewModel.resetSearchResultsDataState()
            }
        }
    }
    private var searchBarView: some View {
        HStack(spacing: 16.0) {
            TextField("Search recipes", text: $viewModel.searchText)
                .textInputAutocapitalization(.never)
                .font(.title3)
                .padding()
                .background(Color.accent.opacity(0.1), in: RoundedRectangle(cornerRadius: 12.0))
                .overlay(alignment: .trailing) {
                    if !viewModel.isSearchButtonDisabled {
                        Button {
                            viewModel.searchText = ""
                            viewModel.resetSearchResultsDataState()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                        }
                        .padding(.horizontal)
                        .transition(.scale)
                    }
                }
            Button {
                Task { await viewModel.searchForResults() }
            } label: {
                Image(systemName: "arrow.forward")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 36.0, height: 36.0)
            }
            .disabled(viewModel.isSearchButtonDisabled)
        }
        .padding(.horizontal, 16.0)
        .padding(.top, 16.0)
        .animation(.spring, value: viewModel.isSearchButtonDisabled)
    }
    @ViewBuilder
    private var searchResultsView: some View {
        switch viewModel.searchResultsDataState {
        case .idle:
            searchIdleView
        case .loading:
            searchProgressView
        case .success(let searchResults):
            let recipes = searchResults.map { $0.toRecipe() }
            searchRecipesView(recipes: recipes)
        case .failure(let error):
            ErrorView(error: error)
        }
    }
    private var searchIdleView: some View {
        VStack {
            Image(.chefHat)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120.0, height: 120.0)
                .foregroundStyle(.accent.gradient)
            Text("Search for recipes")
                .font(.headline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    private var searchProgressView: some View {
        VStack {
            ProgressView()
            Text("Searching for \(viewModel.searchText)...")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    private func searchRecipesView(recipes: [Recipe]) -> some View {
        ZStack {
            if recipes.isEmpty {
                ContentUnavailableView
                    .search(text: viewModel.searchText)
            } else {
                ScrollView(.vertical) {
                    LazyVStack(spacing: 12.0) {
                        ForEach(recipes) { recipe in
                            NavigationLink(value: recipe) {
                                RecipeView(recipe: recipe)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .contentMargins(16.0)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    NavigationStack {
        SearchView(recipeRepository: RemoteRecipeRepository(apiService: MealsDbApiService()))
    }
}
