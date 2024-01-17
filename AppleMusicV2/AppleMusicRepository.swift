//
//  CountryRepository.swift
//  AppleMusicV2
//
//  Created by CONG LE on 12/7/23.
//

import Foundation

class AppleMusicRepository {
    private let appleMusicService: AppleMusicService
    private var cachedAlbums: [AlbumViewModel]?

    init(appleMusicService: AppleMusicService) {
        self.appleMusicService = appleMusicService
    }
    
    func fetchAppleMusic(completion: @escaping ([AlbumViewModel]?, Error?) -> Void) {
        // First, attempt to use the cached data
        if let cached = cachedAlbums {
            completion(cached, nil)
            return
        }
        //TODO: Cache the fetched data into Core Data for futher use
        
        // No cache, so fetch from the service
        appleMusicService.fetchAppleMusic { [weak self]  fetchedAppleFeed, error in
            if let receivedFeedData = fetchedAppleFeed {
                let albumViewModels = receivedFeedData.feed.results.map(AlbumViewModel.init)
                
                // Cache the fetched album
                self?.cachedAlbums = albumViewModels
                completion(albumViewModels, nil)
            } else if let error = error {
                completion(nil, error)
            }
        }
    }
    
    // Optionally, provide a method to clear the cache
     func clearCache() {
         cachedAlbums = nil
     }
}
