//
//  FeedViewModel.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-05-01.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published var tweets = [Tweet]()

    init() { fetchTweets() }

    func fetchTweets() {
        let url = URL(string: "http://localhost:3000/tweets")

        guard let url = url else { return }

        NetworkRequest.makeGetRequest(
            url: url,
            httpHeaders: nil,
            res: [Tweet].self
        ) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.tweets = data as! [Tweet]
                }
            case .failure(let error):
                print("ERROR with decdable: \(error.localizedDescription)")
            }
        }
    }
}
