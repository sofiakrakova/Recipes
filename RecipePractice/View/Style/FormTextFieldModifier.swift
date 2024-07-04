//
//  FormTextFieldModifier.swift
//  RecipePractice
//
//  Created by Sofia Krakova on 04.07.2024.
//

import SwiftUI

struct FormTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        VStack {
            HStack {
                content
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.horizontal)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding(.trailing)
            
            Divider()
                .frame(height: 1)
                .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                .padding(.horizontal)
        }
    }
}


extension View {
    func customTextFieldStyle() -> some View {
        self.modifier(FormTextFieldModifier())
    }
}
