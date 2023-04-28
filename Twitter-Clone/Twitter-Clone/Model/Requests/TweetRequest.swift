//
//  TweetRequest.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-20.
//

import Foundation

struct TweetRequest: Encodable {
    let text: String
    let userId: String
    let username: String
    let user: String
}
