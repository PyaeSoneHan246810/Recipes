//
//  ContentView.swift
//  Recipes
//
//  Created by Dylan on 3/7/25.
//

import SwiftUI

struct ContentView: View {
    let remoteCategoryRepository = RemoteCategoryRepository(apiService: MealsDbApiService())
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                NavigationStack {
                    HomeView(
                        categoryRepository: remoteCategoryRepository
                    )
                }
            }
            Tab("Search", systemImage: "magnifyingglass") {
                
            }
            Tab("Saved", systemImage: "bookmark") {
                
            }
        }
    }
}

#Preview {
    ContentView()
}
