//
//  TitleModifier.swift
//  Recipe
//
//  Created by Sofia Krakova on 26.06.2024.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.largeTitle, design: .rounded))
            .bold()
            .padding(.bottom, 30)
            .foregroundColor(.blue)
    }
}
