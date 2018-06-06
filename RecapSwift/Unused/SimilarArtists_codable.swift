//
//  CustomObject.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-19.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
// guard let getSimilar = try? SimilarArtists.decode(data: data) else { return }


/*import UIKit

struct SimilarArtists: Search, Codable {
    
    let artists: [Artist]
    
    enum SimilarKeys: String, CodingKey {
        case similarArtists = "similarartists"
        case artist = "artist"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SimilarKeys.self)
        let similar = try container.nestedContainer(keyedBy: SimilarKeys.self, forKey: .similarArtists)
        artists = try similar.decode([Artist].self, forKey: .artist)
    }
    
}

struct Artist: Codable {
    
    let name: String
    let id: String?
    let match: String
    let url: URL
    let images: [ArtistImage]
    let streamable: Bool
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "mbid"
        case match = "match"
        case url = "url"
        case images = "image"
        case streamable = "streamable"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        match = try container.decode(String.self, forKey: .match)
        url = try container.decode(URL.self, forKey: .url)
        images = try container.decode([ArtistImage].self, forKey: .images)

        let isStreamable = try container.decode(String.self, forKey: .streamable)
        streamable = isStreamable.boolFromString()
        
        if let id = try container.decodeIfPresent(String.self, forKey: .id) {
            self.id = id
        } else {
            self.id = nil
        }
    }
}

struct ArtistImage: Codable {
    
    let url: URL?
    let size: ImageSize?
    
    enum ImageKeys: String, CodingKey {
        case url = "#text"
        case size = "size"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ImageKeys.self)
        url = try container.decodeIfPresent(URL.self, forKey: .url)
       
        if let imgSize = try container.decodeIfPresent(String.self, forKey: .size) {
            size = ImageSize(rawValue: imgSize)
        } else {
            size = nil
        }
    
    }
}


extension SimilarArtists: Calculatable {
    
    static func <(lhs: SimilarArtists, rhs: SimilarArtists) -> Bool {
        return false
    }
    
    static func ==(lhs: SimilarArtists, rhs: SimilarArtists) -> Bool {
        return false
    }
    
}*/

