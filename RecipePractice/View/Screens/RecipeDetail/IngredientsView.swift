//
//  IngredientsView.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 17.07.2024.
//

import SwiftUI

struct IngredientsView: View {
    var ingredients: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(NSLocalizedString(LocalizationKeys.ingredients, comment: ""))
                .font(.headline)
                .padding(.top)
            ForEach(ingredients, id: \.self) { ingredient in
                HStack {
                    Text("- \(ingredient)")
                        .padding(.vertical, 4)
                    Spacer()
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
}
