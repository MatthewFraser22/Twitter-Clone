//
//  CustomAuthTextField.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-08.
//

import SwiftUI

struct CustomAuthTextField: View {
    var placeholder: String
    var isSecureTxtField: Bool
    @Binding var text: String

    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray)
                }

                if isSecureTxtField {
                    SecureField("", text: $text)
                        .frame(height: 45)
                        .foregroundColor(.backgroundblue)
                } else {
                    TextField("", text: $text)
                        .frame(height: 45)
                        .foregroundColor(.backgroundblue)
                }
            }

            Rectangle()
                .frame(height: 1, alignment: .center)
                .foregroundColor(.gray)
                .padding(.top, -2)
        }.padding(.horizontal)
    }
}

struct CustomAuthTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomAuthTextField(placeholder: "", isSecureTxtField: false, text: .constant("placeholder text"))
    }
}
