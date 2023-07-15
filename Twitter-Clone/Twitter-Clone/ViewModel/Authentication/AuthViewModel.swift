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
    static let shared = AuthViewModel()

    init() {
       let token = defaults.string(forKey: "jsonwebtoken")
        //let remove = defaults.removeObject(forKey: "jsonwebtoken")
        logout()
//        if token != nil {
//            if let userId = defaults.string(forKey: "userid") {
//                fetchUser(userId: userId)
//            }
//        } else {
//            isAuthenticated = false
//        }
		generateTestUser()
    }

	func generateTestUser() {
		let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDM1Y2ZiYzE4MDU3ODMxNDVkYTUyNDEiLCJpYXQiOjE2ODEzMTk1NjZ9.5ZdUEuFcSQylpIlDvX358bWAJd5Q8THe7jcP8Fbx13Y"
		fetchUser(userId: "64b30a621ceee74caf8671a3")
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
                print("Error setting user \(error)")
            }
        }
    }

    #warning("TOOD - replace force unwrap")
    func login(email: String, password: String) {

        print("LOGGGING IN \(password) \(email)")
        AuthServices.login(email: email, password: password) { result in
            switch result {
            case .success(let data):
                guard let data = data else {
                    print("Error: No data")
                    return
                }

                do {
                    //let json = String(data: data, encoding: .utf8)?.data(using: .utf8)
                    let response = try JSONDecoder().decode(ApiResponse.self, from: data)

                    DispatchQueue.main.async { [self] in
                        defaults.set(response.token, forKey: "jsonwebtoken")
                        defaults.set(response.user.id, forKey: "userid")
                        self.isAuthenticated = true
                        
                        self.currentUser = response.user
                        print("logged in")
                        print(response.user.id)
                    }
                } catch let error {
                    print("ERROR: Failed to decode the data \(error)")
                }

            case .failure(let error):
                print("FAILURE: \(error)")
                print(error.localizedDescription)
            }
        }
    }

    func register(name: String, username: String, email: String, password: String) {
        AuthServices.register(email: email, username: username, password: password, name: name) { result in
            switch result {
            case .success(let data):
				guard let data = data else {
					print("Error data is nil could not register user!")
					return
				}

				do {
					let response = try JSONDecoder().decode(ApiResponse.self, from: data)
					DispatchQueue.main.async { [weak self] in
						guard let self = self else { return }

						defaults.set(response.token, forKey: "jsonwebtoken")
						defaults.set(response.user.id, forKey: "userid")
						self.currentUser = response.user
						self.isAuthenticated = true
					}
				} catch let error {
					print("Error registering account failed to decode response data with error: \(error)")
				}
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func logout() {
        let dictonary = defaults.dictionaryRepresentation()

        dictonary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }

        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
}
