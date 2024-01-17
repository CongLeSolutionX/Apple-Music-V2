//
//  ListOfMusicResultsViewModel.swift
//  AppleMusicV2
//
//  Created by CONG LE on 12/7/23.
//

import Foundation

class ListOfAlbumViewModels {
    // This service should ideally be injected rather than instantiated directly,
    // to facilitate testing and to conform to the dependency inversion principle.
    private let repository: AppleMusicRepository
    
    // An array to hold the view models for countries, to be used by the table view
    private(set) var albumViewModels: [AlbumViewModel] = []
    
    
    var onError: ((Error) -> Void)?
    var onMusicResultFetched: (() -> Void)?
    
    init(repository: AppleMusicRepository) {
        self.repository = repository
    }
    
    // Fetch music results from repository
    func fetchMusicResults() {
        repository.fetchAppleMusic { [weak self] albumViewModels, error in
            DispatchQueue.main.async {
                if let viewModels = albumViewModels {
                    self?.albumViewModels = viewModels
                    self?.onMusicResultFetched?()
                } else if let error = error {
                    self?.onError?(error)
                }
            }
        }
    }
}
