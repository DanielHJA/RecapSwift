//
//  topAlbumCollectionViewCell.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-22.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class TopAlbumCollectionViewCell: CustomCollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellWith(_ album: Album) {
        imageView.kf.setImage(with: album.images[2].url)
        titleLabel.text = album.name
    }
    
    
}
