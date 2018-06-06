//
//  SimilarCollectionViewCell.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-22.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit
import Kingfisher

class SimilarCollectionViewCell: CustomCollectionViewCell {
    
    private lazy var matchView: MatchView = {
        let temp = MatchView(frame: CGRect(x: 0, y: 0, width: frame.width * 0.3, height: frame.height * 0.3))
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15.0).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15.0).isActive = true
        temp.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        temp.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellWith(_ artist: Artist) {
        imageView.kf.setImage(with: artist.images[2].url)
        titleLabel.text = artist.name
    }
    
    func match(_ artist: Artist) {
        if let formattedNumber = NumberFormatter().number(from: artist.match) {
            matchView.percentage = formattedNumber.doubleValue
        }
    }
    
}
