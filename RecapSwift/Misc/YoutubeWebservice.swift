//
//  YoutubeManager.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-30.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class YoutubeWebservice {

    class func fetch(key: String, completion: @escaping (String) -> (), failure: @escaping(Error?) -> ()) {
        let url: String = "\(Constants.Youtube.root)q=\(key)%20-vevo%20-SME%20-Sony&part=snippet&type=video&maxResults=1&key=\(Constants.Youtube.key)"
        
        Alamofire.request(url).validate().responseJSON { (response) in
            guard let data = response.data else {
                failure(response.error)
                return
            }
            
            guard let video = Mapper<YoutubeVideo>().map(JSONString: data.toString()) else { return }
            let videoKey = video.items[0].videoKey
            completion(videoKey)
        }
    }
    
}
