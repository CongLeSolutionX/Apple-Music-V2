//
//  ImageService.swift
//  AppleMusicV2
//
//  Created by CONG LE on 1/17/24.
//

import UIKit

class ImageService {
    static let shared = ImageService()

    func fetchImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        // Fetch image data from the URL
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
