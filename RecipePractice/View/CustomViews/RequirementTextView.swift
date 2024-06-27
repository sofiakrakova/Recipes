//
//  RequirementTextView.swift
//  Recipe
//
//  Created by Sofia Krakova on 26.06.2024.
//

import SwiftUI

struct RequirementTextView: View {

    var iconName = "xmark.square"
    var iconColor = Color(red: 72/255, green: 167/255, blue: 238/255)
    var text = ""
    var isStrikeThrough = false
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(iconColor)
            Text(text)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.secondary)
                .strikethrough(isStrikeThrough)
                .fontWeight(.thin)
        }
    }
}

//#Preview {
//    RequirementTextView()
//}
