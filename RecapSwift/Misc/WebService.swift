//
//  WebService.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-19.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class WebService {

    class func fetch(key: String, method: SearchMethods, completion: @escaping ([Any]) -> (), failure: @escaping(CustomError) -> ()) {
        let url: String = "\(Constants.API.root)method=\(method.rawValue)&artist=\(key)&api_key=\(Constants.API.key)&limit=50&format=json"

        Alamofire.request(url).validate().responseJSON { (response) in
            guard let data = response.data else {
                failure(.noResults)
                return
            }
            
            if response.result.isFailure {
                if let error = response.result.error as? AFError, error.responseCode == 499 {
                    // Invalid session error
                } else {
                    // Network error
                    failure(.noConnection)
                }
            }
            
        switch method {
            case .artist:
                guard let jsonArray = data.extractJSON(key: "artist", paths: ["similarartists"]), let artists = Mapper<Artist>().mapArray(JSONString: jsonArray.toString()) else {
                    failure(.unableToSerialize)
                    return
                }
                completion(artists)
            case .album:
                guard let jsonArray = data.extractJSON(key: "album", paths: ["topalbums"]), let albums = Mapper<Album>().mapArray(JSONString: jsonArray.toString()) else {
                    failure(.unableToSerialize)
                    return
                }
                completion(albums)
            case .track:
                guard let jsonArray = data.extractJSON(key: "track", paths: ["toptracks"]), let tracks = Mapper<Track>().mapArray(JSONString: jsonArray.toString()) else {
                    failure(.unableToSerialize)
                    return
                }
                completion(tracks)
            }
        }
    }
}
