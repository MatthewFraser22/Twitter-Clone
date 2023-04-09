//
//  MessageCellView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-05.
//

import SwiftUI

struct MessageCellView: View {

    var body: some View {
        VStack {
            Divider()

            HStack(alignment: .top, spacing: 3) {

                Image("blankpp")
                    .resizable()
                    .frame(width: 56, height: 56)
                    .clipShape(Circle())

                VStack(alignment: .leading) {
                    HStack(spacing: 8) {
                        Text("Matt")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        Text("@matt_fraser")
                            .foregroundColor(.gray)
                    }

                    HStack(spacing: 0) {
                        Text("You: ")
                            .foregroundColor(.gray)
                        Text("Send the puppy")
                            .foregroundColor(.gray)
                    }
                }

                Spacer()

                Text("6/4/2023")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width, height: 70)
        
    }
}

struct MessageCellView_Previews: PreviewProvider {
    static var previews: some View {
        MessageCellView()
    }
}
