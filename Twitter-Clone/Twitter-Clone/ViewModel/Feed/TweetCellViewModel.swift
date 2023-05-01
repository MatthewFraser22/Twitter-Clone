//
//  TweetCellViewModel.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-05-01.
//

import Foundation
import SwiftUI

class TweetCellViewModel: ObservableObject {
    @Published var tweet: Tweet

    init(tweet: Tweet) {
        self.tweet = tweet
    }
}
