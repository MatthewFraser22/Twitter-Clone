//
//  CustomProfileTextField.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-05-01.
//

import SwiftUI

struct CustomProfileTextField: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        HStack {
            ZStack {
                HStack {
                    if text.isEmpty {
                        Text(placeholder)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }
                
                TextField("", text: $text)
                    .foregroundColor(.blue)
            }
        }
    }
}

struct CustomProfileTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomProfileTextField(text: .constant(""), placeholder: "")
    }
}
