//
//  RegisterUserRequest.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-20.
//

import Foundation

struct RegisterUserRequest: Encodable {
    let email: String
    let username: String
    let password: String
    let name: String
}
