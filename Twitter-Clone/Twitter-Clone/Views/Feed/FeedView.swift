//
//  FeedView.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-03.
//

import SwiftUI

struct FeedView: View {
    let user: User
    @ObservedObject var vm = FeedViewModel()

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 18) {
                ForEach(vm.tweets) { tweet in
                    TweetCellView(viewModel: TweetCellViewModel(tweet: tweet))

                    Divider()
                }
            }
            .padding([.top, .horizontal])
            .zIndex(0)
        }
    }
}

//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView()
//    }
//}
