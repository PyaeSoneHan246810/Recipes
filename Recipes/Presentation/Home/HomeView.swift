//
//  HomeView.swift
//  Recipes
//
//  Created by Dylan on 3/7/25.
//

import SwiftUI
import SwiftUINavigationTransitions

struct HomeView: View {
    let categoryRepository: CategoryRepository
    let recipeRepository: RecipeRepository
    @State private var viewModel: HomeViewModel
    init(categoryRepository: CategoryRepository, recipeRepository: RecipeRepository) {
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor : UIColor.accent,
        ]
        self.categoryRepository = categoryRepository
        self.recipeRepository = recipeRepository
        _viewModel = State(
            initialValue: HomeViewModel(categoryRepository: categoryRepository, recipeRepository: recipeRepository)
        )
    }
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20.0) {
                VStack(alignment: .leading, spacing: 12.0) {
                    headerView
                    categorySelectionView
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                recipesView
            }
        }
        .scrollIndicators(.hidden)
        .contentMargins(.vertical, 12.0)
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Recipe.self) { recipe in
            RecipeDetailsView(recipe: recipe, recipeRepository: recipeRepository)
        }
        .navigationTransition(
            .slide(axis: .horizontal).combined(with: .fade(.in)),
            interactivity: .pan
        )
        .task {
            if !viewModel.categoriesDataState.isSuccess {
                await viewModel.getCategories()
            }
        }
    }
    private var headerView: some View {
        Text("What do you want to cook today?")
            .font(.title2)
            .fontWeight(.semibold)
            .padding(.horizontal, 16.0)
    }
    private var categorySelectionView: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 8.0) {
                ChipView(
                    title: "All",
                    isSelected: viewModel.selectedCategoryName == nil,
                    onTap: { _ in
                        viewModel.selectCategory(with: nil)
                    }
                )
                switch viewModel.categoriesDataState {
                case .idle:
                    EmptyView()
                case .loading:
                    ProgressView()
                case .success(let categories):
                    ForEach(categories) { category in
                        let categoryName = category.name
                        let isSelected = categoryName == viewModel.selectedCategoryName
                        ChipView(
                            title: categoryName,
                            isSelected: isSelected,
                            onTap: { tappedCategoryName in
                                viewModel.selectCategory(with: tappedCategoryName)
                            }
                        )
                    }
                case .failure(_):
                    EmptyView()
                }
            }
        }
        .scrollIndicators(.hidden)
        .contentMargins(.horizontal, 16.0)
    }
    @ViewBuilder
    private var recipesView: some View {
        if viewModel.selectedCategoryName == nil {
            allRecipesView
        } else {
            recipesByCategoryView
        }
    }
    @ViewBuilder
    private var allRecipesView: some View {
        switch viewModel.allRecipesDataState {
        case .idle:
            EmptyView()
        case .loading:
            ProgressView()
        case .success(let recipes):
            LazyVStack(spacing: 12.0) {
                ForEach(recipes) { recipe in
                    NavigationLink(value: recipe) {
                        RecipeView(recipe: recipe)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16.0)
        case .failure(let error):
            ContentUnavailableView(error.localizedDescription, systemImage: "exclamationmark.triangle.fill", description: Text(error.localizedDescription))
        }
    }
    @ViewBuilder
    private var recipesByCategoryView: some View {
        switch viewModel.recipesByCategoryDataState {
        case .idle:
            EmptyView()
        case .loading:
            ProgressView()
        case .success(let recipes):
            LazyVStack(spacing: 12.0) {
                ForEach(recipes) { recipe in
                    NavigationLink(value: recipe) {
                        RecipeView(recipe: recipe)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16.0)
        case .failure(let error):
            ContentUnavailableView(error.localizedDescription, systemImage: "exclamationmark.triangle.fill", description: Text(error.localizedDescription))
        }
    }
}

#Preview {
    NavigationStack {
        HomeView(
            categoryRepository: RemoteCategoryRepository(apiService: MealsDbApiService()),
            recipeRepository: RemoteRecipeRepository(apiService: MealsDbApiService())
        )
    }
}
