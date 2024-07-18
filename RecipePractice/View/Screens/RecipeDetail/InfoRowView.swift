//
//  InfoRowView.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 17.07.2024.
//

import SwiftUI

struct InfoRowView: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title)
                .bold()
            Spacer()
            Text(value)
        }
        .padding(.vertical, 5)
    }
}
