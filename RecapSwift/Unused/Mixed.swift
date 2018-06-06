//
//  Mixed.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-22.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class Mixed: NSObject {
    
    /*
     protocol Filter {
     associatedtype T
     func values(_ forMethod: SearchMethods) -> [String]
     static var allValues: [T] { get }
     }
     
     extension Filter {
     func values(_ forMethod: SearchMethods) -> [String] {
     switch forMethod {
     case .artist:
     return FilterArtist.allValues.map { return $0.rawValue }
     case .album:
     return []
     case .track:
     return FilterTrack.allValues.map { return $0.rawValue }
     }
     }
     }
     
     enum FilterArtist: String, Filter {
     typealias T = FilterArtist
     
     case name = "Name"
     case match = "Match"
     static var allValues: [T] = [.name, .match]
     }
     */
    
    // Static lets yu accessmethod without creating instance
    
    /* if let obj = object as? TopAlbums {
     print("topalbum")
     }*/
    
    /*extension String {
        func boolFromString() -> Bool {
            return self == "0" ? false : true
        }
    }*/

    /*private lazy var blurView: UIVisualEffectView = {
     let temp = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.dark))
     temp.frame = view.bounds
     return temp
     }()*/
    
    // Add padding to textfield
    /*let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
     temp.leftView = leftView
     temp.leftViewMode = .always*/

    /*
     DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
     loadingView.isLoading = false
     }*/
}
