//
//  CountryService.swift
//  AppleMusicV2
//
//  Created by CONG LE on 12/7/23.
//

import Foundation

class AppleMusicService {

    // URLSession is used to create a network request.
    func fetchAppleMusic(completion: @escaping (AppleMusicData?, Error?) -> Void) {
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

            // Attempt to decode the data into an array of Country objects.
            do {
                let fetchedData = try JSONDecoder().decode(AppleMusicData.self, from: data)
                // Call completion handler with the decoded country data on success.
                completion(fetchedData, nil)
            } catch {
                // Call completion handler with the error on failure.
                completion(nil, error)
            }
        }

        // Start the network request.
        task.resume()
    }
}
