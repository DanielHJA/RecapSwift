//
//  DetailsViewController.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-29.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var item: Any?
    
    private lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50.0)
        temp.textColor = UIColor.white
        temp.textAlignment = .center
        temp.font = UIFont(name: "AvenirNextCondensed-Bold", size: 30.0)
        temp.numberOfLines = 1
        temp.adjustsFontSizeToFitWidth = true
        temp.lineBreakMode = .byTruncatingTail
        scrollView.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        temp.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        temp.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        temp.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollView.contentSize = temp.bounds.size
        return temp
    }()
    
    private lazy var imageView: UIImageView = {
        let temp = UIImageView()
        temp.contentMode = .scaleAspectFill
        temp.clipsToBounds = true
        temp.layer.borderWidth = 1.0
        temp.layer.borderColor = UIColor.white.cgColor
        scrollView.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15.0).isActive = true
        temp.widthAnchor.constraint(equalToConstant: view.frame.width * 0.6).isActive = true
        temp.heightAnchor.constraint(equalToConstant: view.frame.width * 0.6).isActive = true
        temp.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        scrollView.contentSize.height += view.frame.width * 0.6
        return temp
    }()
    
    private lazy var matchingLabel: UILabel = {
        let temp = UILabel()
        temp.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50.0)
        temp.textColor = UIColor.white
        temp.textAlignment = .center
        temp.font = UIFont(name: "AvenirNextCondensed-Bold", size: 30.0)
        temp.numberOfLines = 1
        temp.adjustsFontSizeToFitWidth = true
        temp.lineBreakMode = .byTruncatingTail
        scrollView.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15.0).isActive = true
        temp.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        temp.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        temp.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollView.contentSize.height += temp.bounds.size.height + 15.0
        return temp
    }()
    
    private lazy var videoPlayerView: YoutubeVideoPlayerView = {
        let temp = YoutubeVideoPlayerView()
        temp.layer.borderColor = UIColor.white.cgColor
        temp.layer.borderWidth = 2.0
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        return temp
    }()
    
    private lazy var scrollView: UIScrollView = {
        let temp = UIScrollView()
        temp.bounces = false
        temp.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor).isActive = true
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        return temp
    }()
    
    private lazy var rightbarButton: UIBarButtonItem = {
        let temp = UIBarButtonItem(title: "Web", style: .plain, target: self, action: #selector(openWeb))
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let object = item else {
            navigationController?.popViewController(animated: true)
            return
        }
        navigationItem.rightBarButtonItem = rightbarButton
        setup(object)
    }
    
    private func setup(_ obj: Any) {
        if let artist = obj as? Artist {
            setupWith(artist)
        }
        
        if let album = obj as? Album {
            setupWith(album)
        }
        
        if let track = obj as? Track {
            setupWith(track)
        }
    }
    private func setupWith(_ track: Track) {
        titleLabel.text = track.name
        if let img = track.images[1].url {
            imageView.kf.setImage(with: img)
        }
        title = track.name
        videoPlayerView.searchString = track.name
    }
    
    private func setupWith(_ album: Album) {
        titleLabel.text = album.name
        if let img = album.images[1].url {
            imageView.kf.setImage(with: img)
        }
        title = album.name
        videoPlayerView.searchString = album.name
    }
    
    private func setupWith(_ artist: Artist) {
        titleLabel.text = artist.name
        if let img = artist.images[1].url {
            imageView.kf.setImage(with: img)
        }
        matchingLabel.text = artist.match
        title = artist.name
        videoPlayerView.searchString = artist.name
    }
    
    @objc private func openWeb() {
        guard let obj = item as? URLClass else { return }
        openURL(url: obj.url)
    }
    
    private func openURL(url: URL?) {
        if let url = url {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
