//
//  CountryService.swift
//  AppleMusicV2
//
//  Created by CONG LE on 12/7/23.
//

import Foundation

class AppleMusicService: ErrorLogging {
    
    func fetchAppleMusic(completion: @escaping (AppleMusic?, NetworkError?) -> Void) {
        guard let urlLink = AppleITuneAPI.getAlbumURL() else {
            completion(nil, NetworkError.badURL)
            return
        }
        
        let urlString = urlLink.absoluteString
        
        NetworkService.shared.fetchDecodable(from: urlString) { [weak self] (result: Result<AppleMusic, NetworkError>) in
            switch result {
                
            case .success(let fetchedData):
                // TODO: create a log mechanism instead of using print statement
                self?.prettyPrintJson(fetchedData)
                completion(fetchedData, nil)
            case .failure(let error):
                self?.logError(error)
                completion(nil, error)
            }
        }
    }
    
    private func prettyPrintJson<T: Codable>(_ data: T) {
        do {
            let jsonData = try JSONEncoder().encode(data)
            if let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []),
               let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
               let prettyPrintedString = String(data: prettyJsonData, encoding: .utf8) {
                print("Fetched JSON string:\n\(prettyPrintedString)") //TODO: Use a log mechanism instead of print
            }
        } catch {
            print("Error pretty printing JSON: \(error)")
        }
    }

}
