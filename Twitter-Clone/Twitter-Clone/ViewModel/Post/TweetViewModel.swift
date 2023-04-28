//
//  TweetViewModel.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-20.
//

import Foundation
import SwiftUI

class TweetViewModel: ObservableObject {
    @ObservedObject var authViewModel: AuthViewModel = AuthViewModel.shared

    func uploadTweet(
        text: String
        //completion: @escaping (_ result: [String : Any]?) -> Void
    ) {
        guard let user = authViewModel.currentUser else { return }

        let params: TweetRequest = TweetRequest(text: text, userId: user.id, username: user.username, user: user.name)

        let url = URL(string: "http://localhost:3000/tweets")

        guard let url = url else { return }

        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")!

        NetworkRequest.makePostRequest(
            url: url,
            body: params.self,
            headers: [
                "Authorization" : "Bearer \(token)",
                "Content-Type" : "application/json",
                "Accept" : "application/json"
            ]
        ) { result in
            switch result {
            case .success(_): break
                print("Success uploaded tweet")
            case .failure(let error): break
                print("Failure to uplaod tweet \(error)")
            }
        }
    }
}
