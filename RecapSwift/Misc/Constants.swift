//
//  Constants.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-19.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

typealias Calculatable = Comparable & Equatable

protocol Filter { }

enum FilterArtist: String, Filter {
    case name = "Name"
    case match = "Match"
    static let allValues: [FilterArtist] = [.name, .match]
    static let rawValues: [String] = FilterArtist.allValues.map { return $0.rawValue }
}

enum FilterTrack: String, Filter {
    case name = "Name"
    case playCount = "PlayCount"
    case rank = "Rank"
    static let allValues: [FilterTrack]  = [.name, .playCount, .rank]
    static let rawValues: [String] = FilterTrack.allValues.map { return $0.rawValue }
}

enum CustomError: String {
    case noConnection = "Please check your internet connection"
    case noResults = "No results :("
    case unableToSerialize = "Something went wrong when fetching results"
}

enum ImageSize: String, Codable {
    case small = "small"
    case medium = "medium"
    case large = "large"
    case extralarge = "extralarge"
    case mega = "mega"
}

enum SearchMethods: String {
    case artist = "artist.getSimilar"
    case album = "artist.getTopAlbums"
    case track = "artist.getTopTracks"
    
    static let allValues = ["Artist","Album","Tracks"]
    
    func filterMethods() -> [Filter]? {
        switch self {
        case .artist:
            return FilterArtist.allValues
        case .album:
            return nil
        case .track:
            return FilterTrack.allValues
        }
    }
    
    static func caseFromIndex(_ index: Int) -> SearchMethods {
        switch index {
        case 0:
            return .artist
        case 1:
            return .album
        case 2:
            return .track
        default:
            return .artist
        }
    }
}

struct Constants {

    struct API {
        static let root: String = "http://ws.audioscrobbler.com/2.0/?"
        static let key: String = "8dd4466b18a9a013fcea7120574792ce"
        static let secret: String = "ea7dce321443eb2fc33352f084530f45"
    }
    
    struct Youtube {
        static let key: String = "AIzaSyCFSXDyxVvUmH-MXlNBPAV1DHUjjDhaM9g"
        static let root: String = "https://www.googleapis.com/youtube/v3/search?"
        static let playRoot: String = "https://www.youtube.com/watch?v="
    }
    
}
