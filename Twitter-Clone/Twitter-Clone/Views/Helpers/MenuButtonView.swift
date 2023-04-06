//
//  MenuButtonView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-06.
//

import SwiftUI

struct MenuButtonView: View {
    var imageName: String

    var body: some View {
        HStack(spacing: 15) {
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .frame(width: 24, height: 24)
                .foregroundColor(.gray)
            
            Text(imageName)
                .foregroundColor(.black)
            
            Spacer(minLength: 0)
        }
        .padding(.vertical, 12)
    }
}

struct MenuButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MenuButtonView(imageName: "blankpp")
    }
}
