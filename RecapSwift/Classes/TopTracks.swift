//
//  TopTracks.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-22.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit
import ObjectMapper

class Track: URLClass, Mappable {
        
    var name: String!
    var playcount: Int?
    var listeners: Int?
    var id: String?
    var artist: TopTrackArtist?
    var images: [SearchImage] = []
    var streamable: Bool!
    var rank: Int!
        
    required init?(map: Map) {
        if map.JSON["name"] == nil { return nil }
    }
        
    func mapping(map: Map) {
        name <- map["name"]
        playcount <- (map["playcount"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        listeners <- (map["listeners"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        self.url <- (map["url"], URLTransform())
        artist <- map["artist"]
        images <- map["image"]
        rank <- (map["@attr.rank"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))

        // check if key exist
        if map["mbid"].currentValue != nil {
            id <- map["mbid"]
        } else {
            id = nil
        }
            
        streamable <- (map["streamable"], TransformOf(fromJSON: { (intVal: Int?) -> Bool? in return Bool(truncating: NSNumber(value: intVal ?? 0))
            }, toJSON: { (boolVal: Bool?) -> Int? in return (boolVal ?? false) ? 1 : 0 }))
        }
    }
    
    class TopTrackArtist: Mappable {
        
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
