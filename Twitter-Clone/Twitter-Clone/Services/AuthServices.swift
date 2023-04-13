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
}

enum AuthError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

public class AuthServices {
    public static var requestDomain: String = ""

    static func register(
        email: String,
        username: String,
        password: String,
        name: String,
        completion: @escaping (_ result: Result<Data?, AuthError>) -> Void
    ) {
        let urlString = URL(string: "http://localhost:3000/users")

        guard let urlString = urlString else { return }

        makeRequest(
            urlString: urlString,
            requestBody: ["email" : email, "username" : username, "password" : password, "name" : name]) { result in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(.invalidCredentials))
                }
            }
    }

    static func makeRequest(
        urlString: URL,
        requestBody: [String : Any],
        completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void
    ) {

        let session = URLSession.shared

        var request = URLRequest(url: urlString)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
        } catch let error {
            print(error)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // what kind of data we are sending to the server
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let task = session.dataTask(with: request) { data, response, error in
            guard error != nil else { return }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            // set the body of the request
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] {
                    
                }
            } catch let error {
                completion(.failure(.decodingError))
                print(error)
            }
        }
        task.resume()
    }
}
