//
//  TopAlbums.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-21.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit
import ObjectMapper

class Album: URLClass, Mappable {
    
    var name: String!
    var playcount: Int?
    var id: String?
    var artist: TopAlbumArtist?
    var images: [SearchImage] = []
    
    required init?(map: Map) {
        if map.JSON["name"] == nil { return nil }
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        playcount <- map["playcount"]
        self.url <- (map["url"], URLTransform())
        artist <- map["artist"]
        images <- map["image"]
        
        // check if key exist
        if map["mbid"].currentValue != nil {
            id <- map["mbid"]
        } else {
            id = nil
        }
    }
    
}

class TopAlbumArtist: Mappable {
    
    var name: String!
    var id: String!
    var url: URL?
    
    required init?(map: Map) {
        if map.JSON["name"] == nil { return nil }
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        id <- map["mbid"]
        url <- (map["url"], URLTransform())
    }
}
