//
//  YoutubeVideo.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-30.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit
import ObjectMapper

class YoutubeVideo: Mappable {
    
    var items: [Item] = []
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        items <- map["items"]
    }
    
    
}

class Item: Mappable {
    
    var videoKey: String = ""
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        videoKey <- map["id.videoId"]
    }
    
    
}
