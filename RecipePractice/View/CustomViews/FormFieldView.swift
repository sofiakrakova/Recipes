//
//  FormFieldView.swift
//  Recipe
//
//  Created by Sofia Krakova on 26.06.2024.
//

import SwiftUI

struct FormFieldView: View {
    var fieldName = ""
    @Binding var fieldValue: String
    var isSecure = false
    @State var showText = false
    
    var body: some View {
        VStack {
            HStack {
                if isSecure && !showText {
                    SecureField(fieldName, text: $fieldValue)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .padding(.horizontal)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                else {
                    TextField(fieldName, text: $fieldValue)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .padding(.horizontal)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                if isSecure {
                    Button(action: {
                        showText.toggle()
                    }, label: {
                        showText ? Image(systemName: "eye") : Image(systemName: "eye.slash")
                    })
                }
            }
            .padding(.trailing)
            Divider()
                .frame(height: 1)
                .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                .padding(.horizontal)
        }
    }
}

//#Preview {
//    FormFieldView(fieldName: "fkkf", fieldValue: .constant("ko"))
//}
