//
//  HomeView.swift
//  Recipes
//
//  Created by Dylan on 3/7/25.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel: HomeViewModel
    init(categoryRepository: CategoryRepository) {
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor : UIColor.accent,
        ]
        _viewModel = State(initialValue: HomeViewModel(categoryRepository: categoryRepository))
    }
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0.0) {
                headerView
                Spacer(minLength: 12.0)
                categorySelectionView
            }
        }
        .scrollIndicators(.hidden)
        .contentMargins(.vertical, 12.0)
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
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
            .frame(maxWidth: .infinity, alignment: .leading)
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
            .animation(.spring, value: viewModel.categoriesDataState)
        }
        .scrollIndicators(.hidden)
        .contentMargins(.horizontal, 16.0)
    }
}

#Preview {
    NavigationStack {
        HomeView(
            categoryRepository: RemoteCategoryRepository(apiService: MealsDbApiService())
        )
    }
}
