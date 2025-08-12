//
//  String+Extensions.swift
//  Recipes
//
//  Created by Dylan on 5/7/25.
//

import Foundation

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
