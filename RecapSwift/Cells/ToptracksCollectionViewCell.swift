//
//  ToptracksCollectionViewCell.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-22.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ToptracksCollectionViewCell: CustomCollectionViewCell {
    
    private lazy var matchView: UILabel = {
        let temp = UILabel()
        temp.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        temp.textColor = UIColor.white
        temp.textAlignment = .center
        temp.font = UIFont(name: "AvenirNextCondensed-Bold", size: 30.0)
        temp.numberOfLines = 1
        temp.adjustsFontSizeToFitWidth = true
        temp.lineBreakMode = .byTruncatingTail
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        temp.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0).isActive = true
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
    
    func setupCellWith(_ track: Track) {
        imageView.kf.setImage(with: track.images[2].url)
        titleLabel.text = track.name
        matchView.text = "\(track.playcount ?? 0)"
    }
    
    
}
