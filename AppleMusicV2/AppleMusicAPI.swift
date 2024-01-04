//
//  AppleMusicAPI.swift
//  AppleMusicV2
//
//  Created by CONG LE on 12/7/23.
//

import Foundation

// Tool to generate Apple Music API V2: https://rss.applemarketingtools.com

// Construct the URL for JSON request
struct AppleITuneAPI {
  
  // Top 10 albums: https://rss.applemarketingtools.com/api/v2/us/music/most-played/10/albums.json
  static let base = "https://rss.applemarketingtools.com/api/v2/"
  static let topAlbums = "/us/music/most-played/10/albums.json"
  
  
  static func getAlbumURL() -> URL? {
    return URL(string: base + topAlbums)
  }
}
