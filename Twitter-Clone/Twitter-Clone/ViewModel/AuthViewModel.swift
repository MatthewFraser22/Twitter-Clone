//
//  AuthViewModel.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-13.
//

import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var currentUser: User?
    let defaults = UserDefaults.standard

    init() {
        let token = defaults.string(forKey: "jsonwebtoken")

        if token != nil {
            if let userId = defaults.string(forKey: "userid") {
                fetchUser(userId: userId)
            }
        } else {
            isAuthenticated = false
        }
    }

    func fetchUser(userId: String) {
        AuthServices.fetchUser(userId: userId) { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async { [self] in
                    defaults.setValue(user.id, forKey: "userid")
                    self.currentUser = user
                    isAuthenticated = true
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }

    #warning("TOOD - replace force unwrap")
    func login(email: String, password: String) {

        print("LOGGGING IN \(password) \(email)")
        AuthServices.login(email: email, password: password) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder().decode(ApiResponse.self, from: data!) else { return }

                DispatchQueue.main.async { [self] in
                    defaults.set(response.token, forKey: "jsonwebtoken")
                    defaults.set(response.user.id, forKey: "userid")
                    self.isAuthenticated = true
                    self.currentUser = response.user
                    print("logged in")
                    print(response.user._id)
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func register(name: String, username: String, email: String, password: String) {
        AuthServices.register(email: email, username: username, password: password, name: name) { result in
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder().decode(ApiResponse.self, from: data!) else { return }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func logout() {}
}
