//
//  Tweet.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-20.
//

import Foundation
import SwiftUI

struct Tweet: Identifiable, Decodable {
    var id: String
    let text: String
    let userId: String
    let username: String
    let user: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case text
        case userId
        case username
        case user
    }
}
