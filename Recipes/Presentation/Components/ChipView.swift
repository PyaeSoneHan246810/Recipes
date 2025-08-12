//
//  ChipView.swift
//  Recipes
//
//  Created by Dylan on 4/7/25.
//

import SwiftUI

struct ChipView: View {
    let title: String
    let isSelected: Bool
    let onTap: (String) -> Void
    var backgroundColor: Color {
        isSelected ? .accent : .clear
    }
    var foregroundColor: Color {
        isSelected ? .white : .primary
    }
    var body: some View {
        Text(title)
            .padding(.horizontal, 16.0)
            .padding(.vertical, 8.0)
            .background(backgroundColor.gradient, in: Capsule())
            .foregroundStyle(foregroundColor)
            .overlay {
                Capsule()
                    .strokeBorder(.secondary, style: StrokeStyle(lineWidth: isSelected ? 0.0 : 1.0))
            }
            .animation(.smooth, value: isSelected)
            .onTapGesture {
                onTap(title)
            }
    }
}

#Preview {
    ChipView(title: "Selected", isSelected: true) { _ in
        
    }
    ChipView(title: "Unselected", isSelected: false) { _ in
        
    }
}
