//
//  SearchUserCell.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-04.
//

import SwiftUI

struct SearchUserCell: View {
    var body: some View {
        HStack {
            Image("blankpp")
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .clipShape(Circle())

            VStack(alignment: .leading) {
                Text("Name")
                    .fontWeight(.heavy)
                Text("@matt_fraser")
            }

            Spacer(minLength: 0)
        }
    }
}

struct SearchUserCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchUserCell()
    }
}
