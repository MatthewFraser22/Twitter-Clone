//
//  UserLoginRequest.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-20.
//

import Foundation

struct UserLoginRequest: Encodable {
    var email: String
    var password: String
}
