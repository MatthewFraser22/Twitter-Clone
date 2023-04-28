//
//  NetworkRequest.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-28.
//

import Foundation

class NetworkRequest {
    static let shared = NetworkRequest()

    init() {}

    static func makePostRequest<Req: Encodable>(
        url: URL,
        body: Req,
        headers: [String : String]?,
        completion: @escaping (_ result: Result<Data?, NetworkError>) -> Void
    ) {
        let session = URLSession.shared
        var request = URLRequest(url: url)

        request.httpMethod = "POST"

        do {
            //request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(.failure(.failedToEncodebody))
        }

        if let headers = headers {
            headers.forEach { (key, value) in
                print("value \(value) , Key: \(key)")
                request.addValue(value, forHTTPHeaderField: key)
            }
        } else {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type") // what kind of data we are sending to the server
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }

        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("error: \(error)")
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            completion(.success(data))

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] {
                    print(json)
                }
            } catch let error {
                completion(.failure(.decodingError))
                print(error)
            }
        }

        task.resume()
    }

    static func makeGetRequest<Res: Decodable>(
        url: URL,
        httpHeaders: [String : String]?,
        res: Res.Type,
        completion: @escaping (_ result: Result<Decodable, NetworkError>) -> Void
    ) {
        var session = URLSession.shared

        var request = URLRequest(url: url)

        request.httpMethod = "GET"

        if let header = httpHeaders {
            header.forEach { key, value in
                request.addValue(value, forHTTPHeaderField: key)
            }
        } else {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }

        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else { return }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let response = try JSONDecoder().decode(res.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.decodingError))
            }
        }

        task.resume()
    }
}
