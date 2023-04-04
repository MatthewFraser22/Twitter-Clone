//
//  FeedView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-03.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 18) {
                TweetCellView(tweet: "samole sfsfs", tweetImage: "post")
                Divider()

                ForEach(1...20, id: \.self) { _ in
                    TweetCellView(tweet: sampleText)
                    Divider()
                }
            }
            .padding([.top, .horizontal])
            .zIndex(0)
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
