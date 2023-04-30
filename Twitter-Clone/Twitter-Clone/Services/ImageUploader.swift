//
//  ImageUploader.swift
//  Twitter-Clone
//
//  Created by Matthew Fraser on 2023-04-28.
//

import Foundation
import SwiftUI

struct ImageUploader {

    static func uploadImage(paramName: String, fileName: String, image: UIImage, urlPath: String) {
        let url = URL(string: "http://localhost:3000/\(urlPath)")

        guard let url = url else { return }

        let boundary = UUID().uuidString

        let token = UserDefaults.standard.object(forKey: "jsonwebtoken")

        let session = URLSession.shared
        var request = URLRequest(url: url)

        request.httpMethod = "POST"

        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()

        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)

        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        session.uploadTask(with: request, from: data) { data, response, error in
            guard error == nil else { return }

            guard let data = data else { return }

            let jsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)

            if let json = jsonData as? [String : Any] {
                print(json)
            }
        }.resume()
    }
}
