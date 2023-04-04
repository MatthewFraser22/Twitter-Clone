//
//  SearchView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-03.
//

import SwiftUI

struct SearchView: View {
    @State var searchText: String = ""
    @State var isEditing: Bool = false

    var body: some View {
        VStack {
            SearchBarView(searchText: $searchText, isEditing: $isEditing)

            if !isEditing {
                List(0..<9) { i in
                    SearchCell(tag: "HEHE", numberOfTweets: "\(i)")
                }
            } else {
                List(0..<9) { _ in
                    SearchUserCell()
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
