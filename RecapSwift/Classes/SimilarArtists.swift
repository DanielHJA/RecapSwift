//
//  SimilarArtists2.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-22.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit
import ObjectMapper

class URLClass {
    var url: URL?
}


class Artist: URLClass, Mappable {
   
    var name: String!
    var id: String?
    var match: String!
    var images: [SearchImage] = []
    var streamable: Bool!
    
    required init?(map: Map) {
        if map.JSON["name"] == nil { return nil }
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        match <- map["match"]
        self.url <- (map["url"], URLTransform())
        images <- map["image"]
        streamable <- (map["streamable"], TransformOf(fromJSON: { (intVal: Int?) -> Bool? in return Bool(truncating: NSNumber(value: intVal ?? 0))
        }, toJSON: { (boolVal: Bool?) -> Int? in return (boolVal ?? false) ? 1 : 0 }))
        
        if map["mbid"].currentValue != nil {
            id <- map["mbid"]
        } else {
            id = nil
        }
    }
    
    
}

class SearchImage: Mappable {
    
    var url: URL!
    var size: ImageSize?
    
    required init?(map: Map) {
        if map.JSON["#text"] == nil { return nil }
    }
    
    func mapping(map: Map) {
        url <- (map["#text"], URLTransform())
        size <- (map["size"], EnumTransform<ImageSize>())
    }
}


