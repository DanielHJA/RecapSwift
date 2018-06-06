//
//  VideoPlayerView.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-30.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {

    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    var address: String = "" {
        didSet {
            initPlayerWith(address)
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
    
    convenience init(rect: CGRect) {
        self.init(frame: rect)
        commonInit()
    }
    
    private func commonInit() { }
    
    private func initPlayerWith(_ string: String) {
        guard let url = URL(string: string) else { return }
        
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = bounds
        playerLayer?.videoGravity = .resize
        if let playerLayer = self.playerLayer {
            layer.addSublayer(playerLayer)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(videoEnded), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
    }

    func play() {
        if player?.timeControlStatus != AVPlayerTimeControlStatus.playing {
            player?.play()
        }
    }
    
    func pause() {
        player?.pause()
    }
    
    func stop() {
        player?.pause()
        player?.seek(to: kCMTimeZero)
    }
    
    @objc private func videoEnded() {
        
    }
    
}
