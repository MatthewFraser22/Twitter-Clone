//
//  SearchBarView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-04.
//

import SwiftUI
import UIKit

struct SearchBarView: View {
    @Binding var searchText: String
    @Binding var isEditing: Bool

    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            TextField("Search Twitter", text: $searchText)
                .padding(8)
                .padding(.horizontal, 34)
                .background(Color(uiColor: .systemGray6))
                .cornerRadius(20)
                .overlay {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)

                        Spacer()
                    }
                    .padding()
                }

            Button {
                isEditing = false
                searchText = ""
                UIApplication.shared.resignKeyboard()
            } label: {
                Text("Cancel")
                    .foregroundColor(.black)
                    .padding(.trailing, 8)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
            }

        }
        .padding()
        .onTapGesture {
            self.isEditing = true
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""), isEditing: .constant(true))
    }
}
