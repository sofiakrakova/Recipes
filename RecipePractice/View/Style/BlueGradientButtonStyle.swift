//
//  BlueGradientButtonStyle.swift
//  Recipe
//
//  Created by Sofia Krakova on 26.06.2024.
//

import SwiftUI

struct BlueGradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.body, design: .rounded))
            .foregroundColor(.white)
            .bold()
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 56/255, green: 87/255, blue: 238/255), Color(red: 72/255, green: 167/255, blue: 238/255)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
            .padding(.horizontal)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
