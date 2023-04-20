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
    let name: String
    let username: String
    let email: String
    let location: String?
    let bio: String?
    let website: String?
    let avatarExists: String?
    let followers: [String]
    let followings: [String]

}
//
//
//struct UserResponse: Codable {
//    let user: User
//}
//
//struct User: Codable {
//    let id: String
//    let name: String
//    let username: String
//    let email: String
//    let followers: [String]
//    let followings: [String]
//    let tokens: [Token]
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case name
//        case username
//        case email
//        case followers
//        case followings
//        case tokens
//    }
//}
//
//struct Token: Codable {
//    let token: String
//    let id: String
//
//    enum CodingKeys: String, CodingKey {
//        case token
//        case id = "_id"
//    }
//}
