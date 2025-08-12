//
//  RecipeView.swift
//  Recipes
//
//  Created by Dylan on 4/7/25.
//

import SwiftUI
import Kingfisher

struct RecipeView: View {
    let recipe: Recipe
    var body: some View {
        HStack(spacing: 12.0) {
            if let image = recipe.image {
                KFImage(URL(string: image))
                    .placeholder {
                        Rectangle()
                            .fill(Color(uiColor: .systemGray6))
                            .overlay {
                                ProgressView()
                            }
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120.0, height: 120.0)
                    .clipShape(RoundedRectangle(cornerRadius: 12.0))
            } else {
                RoundedRectangle(cornerRadius: 12.0)
                    .fill(Color(uiColor: .systemGray6))
                    .frame(width: 120.0, height: 120.0)
            }
            
            Text(recipe.name)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
    }
}

#Preview {
    RecipeView(recipe: Recipe.sample)
}
