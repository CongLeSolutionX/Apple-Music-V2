//
//  AlbumDetailViewModel.swift
//  AppleMusicV2
//
//  Created by CONG LE on 1/22/24.
//

import UIKit

struct AlbumDetailViewModel {
    let artworkUrlLink: String
    let albumName: String
    let artistName: String
    let albumKind: String
    let contentAdvisoryRating: String
    let releaseDate: String
    let urlLinkString: String
    
    init(artworkUrlLink: String, albumName: String, artistName: String, albumKind: String, contentAdvisoryRating: String, releaseDate: String, urlLinkString: String) {
        self.artworkUrlLink = artworkUrlLink
        self.albumName = albumName
        self.artistName = artistName
        self.albumKind = albumKind
        self.contentAdvisoryRating = contentAdvisoryRating
        self.releaseDate = releaseDate
        self.urlLinkString = urlLinkString
    }
}
