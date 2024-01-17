//
//  ImageService.swift
//  AppleMusicV2
//
//  Created by CONG LE on 1/17/24.
//

import UIKit

class NetworkService {
    static let shared = NetworkService()

    func fetchData(from urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, nil, URLError(.badURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                completion(data, response, error)
            }
        }.resume()
    }
    
    func fetchImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        fetchData(from: urlString) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }
    }
    
    func fetchDecodable<T: Decodable>(from urlString: String, completion: @escaping (T?, Error?) -> Void) {
        fetchData(from: urlString) { data, _, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(decodedObject, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
}
