//
//  ImageService.swift
//  AppleMusicV2
//
//  Created by CONG LE on 1/17/24.
//

import UIKit

enum NetworkError: Error {
    case badURL
    case requestFailed(statusCode: Int)
    case noData
    case dataDecodingFailed(Error)
    case other(Error)
}

class NetworkService {
    static let shared = NetworkService()

    func fetchData(from urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                
                if let error = error {
                    completion(.failure(.other(error)))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.requestFailed(statusCode: 0)))
                    return
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(.requestFailed(statusCode: httpResponse.statusCode)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                completion(.success(data))
            }
        }.resume()
    }
    
    func fetchImage(from urlString: String, completion: @escaping (Result<UIImage, NetworkError>)  -> Void) {
        self.fetchData(from: urlString) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(.failure(.dataDecodingFailed(URLError(.cannotDecodeContentData))))
                    return
                }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchDecodable<T: Decodable>(from urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        self.fetchData(from: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(.dataDecodingFailed(error)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
