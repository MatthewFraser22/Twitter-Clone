//
//  AuthServices.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-13.
//

import Foundation
import SwiftUI

// MARK: Error Cases

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case failedToEncodebody
}

enum AuthError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

public class AuthServices {
    public static var requestDomain: String = ""
    
    static func fetchUser(
        userId: String,
        completion: @escaping (_ result: Result<User, Error>) -> Void
    ) {
        let url = URL(string: "http://localhost:3000/\(userId)")

        guard let url = url else { return }

        NetworkRequest.makeGetRequest(
            url: url,
            httpHeaders: nil,
            res: User.self
        ) { result in
                switch result {
                case .success(let user):
                    completion(.success(user as! User))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

    static func login(
        email: String,
        password: String,
        completion: @escaping (Result<Data?, AuthError>) -> Void
    ) {
        let urlString = URL(string: "http://localhost:3000/users/login")

        guard let urlString = urlString else { return }

        print("Making login request \(email) \(password)")

        let body = UserLoginRequest(email: email, password: password)

        NetworkRequest.makePostRequest(
            url: urlString,
            body: body,
            headers: nil
        ) { result in
                switch result {
                case .success(let data):
                    print("it was a success \(data)")
                    completion(.success(data))
                case .failure(let error):
                    print("FAILURE:  \(error)")
                    completion(.failure(.invalidCredentials))
                }
            }
    }

    static func register(
        email: String,
        username: String,
        password: String,
        name: String,
        completion: @escaping (_ result: Result<Data?, AuthError>) -> Void
    ) {
        let urlString = URL(string: "http://localhost:3000/users")

        guard let urlString = urlString else { return }

        let body = RegisterUserRequest(email: email, username: username, password: password, name: name)

        NetworkRequest.makePostRequest(
            url: urlString,
            body: body,
            headers: nil
        ) { result in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(_):
                    completion(.failure(.invalidCredentials))
                }
            }
    }

//    // fetch user
//    static func fetchUser(
//        userId: String,
//        completion: @escaping (_ result: Result<User, AuthError>) -> Void
//    ) {
//        let urlString = URL(string: "http://localhost:3000/users/\(userId)")
//
//        guard let urlString = urlString else { return }
//
//        var request = URLRequest(url: urlString)
//        request.httpMethod = "GET"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//        let session = URLSession.shared
//
//        let task = session.dataTask(with: request) { data, response, error in
//            guard error == nil else {
//                completion(.failure(.custom(errorMessage: "Error in url session")))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(.invalidCredentials))
//                return
//            }
//
//            do {
//                let responseUserData = try JSONDecoder().decode(User.self, from: data)
//
//                completion(.success(responseUserData))
//            } catch (let error) {
//                print(error.localizedDescription)
//            }
//        }
//
//        task.resume()
//    }
}


//    static func makeRequest(
//        urlString: URL,
//        requestBody: [String : Any],
//        completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void
//    ) {
//
//        let session = URLSession.shared
//
//        var request = URLRequest(url: urlString)
//        request.httpMethod = "POST"
//
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
//            //request.httpBody = try JSONEncoder().encode(requestBody)
//        } catch let error {
//            print(error)
//        }
//
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // what kind of data we are sending to the server
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//        let task = session.dataTask(with: request) { data, response, error in
//
//            guard error == nil else {
//                print(error)
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(.noData))
//                return
//            }
//
//            completion(.success(data))
//
//            // set the body of the request
//            do {
//                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] {
//                    print(json)
//                }
//            } catch let error {
//                completion(.failure(.decodingError))
//                print(error)
//            }
//        }
//        task.resume()
//    }
