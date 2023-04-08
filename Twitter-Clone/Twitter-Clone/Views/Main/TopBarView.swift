//
//  TopBarView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-06.
//

import SwiftUI

struct TopBarView: View {
    @Binding var x: CGFloat

    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation {
                        x = 0
                    }
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 24))
                        .foregroundColor(.backgroundblue)
                }

                Spacer()

                Image("Twitter")
                    .resizable()
                    .scaledToFill()
                    .padding(.trailing)
                    .frame(width: 20, height: 20)

                Spacer()

            }
            .padding()
            
            Divider()
        }
    }
}

//struct TopBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopBarView()
//    }
//}
