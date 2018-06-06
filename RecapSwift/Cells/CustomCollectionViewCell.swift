//
//  CollectionViewCell.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-23.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let temp = UIImageView(image: nil)
        temp.contentMode = .scaleAspectFill
        temp.frame = bounds
        temp.clipsToBounds = true
        return temp
    }()
    
    private lazy var dimView: UIView = {
        let temp = UIView(frame: imageView.bounds)
        temp.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        temp.layer.borderWidth = 1.0
        temp.layer.borderColor = UIColor.white.cgColor
        return temp
    }()
    
    private lazy var cellContentView: UIView = {
        let temp = UIView(frame: bounds)
        temp.backgroundColor = UIColor.clear
        return temp
    }()
    
    lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.white
        temp.textAlignment = .center
        temp.font = UIFont(name: "AvenirNextCondensed-Bold", size: 30.0)
        temp.numberOfLines = 1
        temp.adjustsFontSizeToFitWidth = true
        temp.lineBreakMode = .byTruncatingTail
        return temp
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        addSubview(imageView)
        addSubview(dimView)
        addSubview(cellContentView)
        cellContentView.addSubview(titleLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        dimView.translatesAutoresizingMaskIntoConstraints = false
        dimView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        dimView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        dimView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        dimView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true

        cellContentView.translatesAutoresizingMaskIntoConstraints = false
        cellContentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cellContentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cellContentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cellContentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: dimView.topAnchor, constant: 20.0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: dimView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: dimView.trailingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40.0).isActive = true

    }
    
   required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
