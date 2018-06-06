//
//  YoutubeVideoPlayerView.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-30.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit
import YouTubePlayer

class YoutubeVideoPlayerView: YouTubePlayerView {
    
    var searchString: String? {
        didSet {
            guard let string = searchString else { return }
            loadVideoWith(string.URLEncoded())
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    convenience init(rect: CGRect, searchString: String) {
        self.init(frame: rect)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.green
    }

    private func loadVideoWith(_ searchString: String) {
        YoutubeWebservice.fetch(key: searchString, completion: { (result) in
            self.loadVideoID(result)
            self.play()
        }) { (error) in
            print("There ws an error loading the youtube video -- \(String(describing: error?.localizedDescription))")
        }
    }
    

}
