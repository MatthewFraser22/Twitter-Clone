//
//  MessagesView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-03.
//

import SwiftUI

struct MessagesView: View {
    var body: some View {
        VStack(alignment: .leading) {

            ScrollView(.vertical, showsIndicators: true) {
                ForEach(0..<20) { _ in
                    MessageCellView()
                }
            }
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
