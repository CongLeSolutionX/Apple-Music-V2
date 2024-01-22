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
    
    var artistUrl: String {
        return self.appleMusicResult.artistURL ?? "No Artist URL link"
    }
    
    var artistId: String {
        return self.appleMusicResult.artistID ?? "No Artist ID"
    }
    
    var albumKind: String {
        return self.appleMusicResult.kind.rawValue
    }
    
    var contentAdvisoryRating: String {
        return self.appleMusicResult.contentAdvisoryRating ?? "No Content Advisory Rating"
    }
    
    var albumName: String {
        return self.appleMusicResult.name
    }
    
    var artworkUrlLink: String {
        return self.appleMusicResult.artworkUrl100
    }
    
    var albumId: String {
        return self.appleMusicResult.id
    }
    
    var releaseDate: String {
        return self.appleMusicResult.releaseDate
    }
    
    var urlLinkString: String {
        return self.appleMusicResult.url
    }
}
