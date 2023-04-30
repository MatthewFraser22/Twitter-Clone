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
        text: String,
        image: UIImage?
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
            case .success(let data):
                do {
                    guard let data = data else { return }

                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else { return }

                    guard let image = image else { return }

                    guard let id = json["_id"] else { return }

                    ImageUploader.uploadImage(paramName: "upload", fileName: "image1", image: image, urlPath: "/uploadTweetImage/\(id)")
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print("Failure to uplaod tweet \(error)")
            }
        }
    }
}
