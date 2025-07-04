//
//  ErrorView.swift
//  Recipes
//
//  Created by Dylan on 5/7/25.
//

import SwiftUI

struct ErrorView: View {
    let error: Error
    var body: some View {
        ContentUnavailableView("Something went wrong!", systemImage: "exclamationmark.triangle.fill", description: Text(error.localizedDescription))
    }
}

#Preview {
    ErrorView(error: RecipeError.recipeNotFound)
}
