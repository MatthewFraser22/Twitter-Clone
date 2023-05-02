//
//  CustomProfileBioTextField.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-05-01.
//

import SwiftUI

struct CustomProfileBioTextField: View {
    @Binding var text: String

    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                if text.isEmpty {
                    HStack {
                        Text("Add a bio to your profile")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding(.top, 8)
                    .padding(.leading, 4)
                    .zIndex(1)
                }

                TextEditor(text: $text)
                    .foregroundColor(.blue)
            }
        }.frame(height: 90)
    }
}

struct CustomProfileBioTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomProfileBioTextField(text: .constant(""))
    }
}
