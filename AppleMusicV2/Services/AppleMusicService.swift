//
//  CountryService.swift
//  AppleMusicV2
//
//  Created by CONG LE on 12/7/23.
//

import Foundation

class AppleMusicService {

    // URLSession is used to create a network request.
    func fetchAppleMusic(completion: @escaping (AppleMusic?, Error?) -> Void) {
        // Create a URL from the given string.
        guard let url =  AppleITuneAPI.getAlbumURL() else {
            completion(nil, URLError(.badURL))
            return
        }

        // Create a data task with the URL.
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // If an error occurred, call the completion handler with the error.
            if let error = error {
                completion(nil, error)
                return
            }

            // Check if response data exists.
            guard let data = data else {
                completion(nil, URLError(.badServerResponse))
                return
            }

            do {
                // print out the json data structure we received
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Fetched JSON string: \(jsonString)")
                }
                
                // Decode the received data
                let fetchedData = try JSONDecoder().decode(AppleMusic.self, from: data)
                // Call completion handler with the decoded country data on success.
                completion(fetchedData, nil)
            } catch {
                // Call completion handler with the error on failure.
                print("Decoding error: \(error)")
                if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .keyNotFound(let key, let context):
                        print("\(key.stringValue) was not found, \(context.debugDescription)")
                    case .typeMismatch(_, let context):
                        print("\(context.debugDescription)")
                    case .valueNotFound(_, let context):
                        print("\(context.debugDescription)")
                    default:
                        print("\(decodingError.localizedDescription)")
                    }
                }
                completion(nil, error)
            }
        }

        // Start the network request.
        task.resume()
    }
}
