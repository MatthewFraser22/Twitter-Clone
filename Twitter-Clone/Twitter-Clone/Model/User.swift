//
//  User.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-12.
//

import Foundation

struct ApiResponse: Decodable {
    let user: User
    let token: String
}

struct User: Decodable, Identifiable { // decode json into User struct
    var _id: String
    var id: String { _id }
    let user: String
    let username: String
    let email: String
    let location: String?
    let bio: String?
    let website: String?
    let avatarExists: String?
    let followers: [String]
    let followings: [String]
    
}
