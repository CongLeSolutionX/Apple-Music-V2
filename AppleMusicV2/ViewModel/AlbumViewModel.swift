//
//  CountryViewModel.swift
//  AppleMusicV2
//
//  Created by CONG LE on 12/7/23.
//

import UIKit

struct AlbumViewModel {

    private let appleMusicResult: Album
    
    init(appleMusicResult: Album) {
        self.appleMusicResult = appleMusicResult
    }
    //TODO: Manipulate Apple Music data and endpoints
   
    var artistName: String {
        return self.appleMusicResult.artistName
    }
    
    var albumName: String {
        return self.appleMusicResult.name
    }
    
    var artworkUrlLink: String {
        return self.appleMusicResult.artworkUrl100
    }
}
