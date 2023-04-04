//
//  TweetCellView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-03.
//

import SwiftUI

struct TweetCellView: View {
    var tweet: String
    var tweetImage: String?

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image("blankpp")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 55, height: 55)
                .clipShape(Circle())

            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text("Matt")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Text("@matt_fraser")
                        .foregroundColor(.primary)
                }

                Text("\(sampleText)")
                    .frame(maxHeight: 100, alignment: .top)

                if let image = tweetImage {
                    GeometryReader { geometryProxy in
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometryProxy.frame(in: .global).width, height: 250)
                            .cornerRadius(15)
                    }.frame(height: 250)
                }
                cellBottom
            }
        }
    }

    private var cellBottom: some View {
        HStack(spacing: 50) {
            Button {
                
            } label: {
                Image("Comments")
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            .foregroundColor(.gray)

            Button {
                
            } label: {
                Image("Retweet")
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            .foregroundColor(.gray)

            Button {
                
            } label: {
                Image("love")
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            .foregroundColor(.gray)

            Button {
                
            } label: {
                Image("upload")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 16, height: 16)
                    .foregroundColor(.gray)
            }
            .foregroundColor(.gray)
        }
        .padding(.top, 4)
    }
}

struct TweetCellView_Previews: PreviewProvider {
    static var previews: some View {
        TweetCellView(tweet: sampleText)
    }
}

var sampleText = "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book."
