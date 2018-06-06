//
//  ViewController.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-19.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.

// Filter presentstioncontroller
// Filter Track by playcount
// Spotify
// Share facebook

import UIKit

class ViewController: UIViewController {
    
    var objects: [Any] = []
    private var currentMethod: SearchMethods?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let temp = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        temp.collectionViewLayout = UICollectionViewFlowLayout()
        temp.backgroundColor = UIColor.black
        temp.allowsMultipleSelection = false
        temp.dataSource = self
        temp.delegate = self
        temp.isPagingEnabled = true
        temp.backgroundView?.backgroundColor = UIColor.red
        temp.register(SimilarCollectionViewCell.self, forCellWithReuseIdentifier: "similarCell")
        temp.register(TopAlbumCollectionViewCell.self, forCellWithReuseIdentifier: "topAlbumCell")
        temp.register(ToptracksCollectionViewCell.self, forCellWithReuseIdentifier: "topTracksCell")
        temp.backgroundColor = UIColor.white
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        return temp
    }()
        
    private lazy var activityView: ActivityView = {
        let temp = ActivityView(width: view.frame.width * 0.8)
        temp.isLoading = true
        temp.loadingMessage = "Searching..."
        temp.center = view.center
        return temp
    }()
    
    private lazy var transitionManager: TransitionManager = {
        return TransitionManager(height: view.frame.size.height / 2, tapToDismiss: false, duration: 1.5, style: .blurred)
    }()
    
    private lazy var leftbarButton: UIBarButtonItem = {
        let temp = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(openFilter))
        temp.isEnabled = false
        return temp
    }()
    
    private lazy var rightbarButton: UIBarButtonItem = {
        let temp = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(openSearch))
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LastSearch"
        navigationItem.leftBarButtonItem = leftbarButton
        navigationItem.rightBarButtonItem = rightbarButton
    }
    
    private func search(_ searchString: String, method: SearchMethods) {
        currentMethod = method
        WebService.fetch(key: searchString, method: method, completion: { [weak self] obj in
            if obj.count < 1 {
                self?.displayMessage("No Results :(")
                self?.filterEnabled(false)
            } else {
                self?.objects = obj
                self?.filterEnabled(true)
            }
            self?.collectionView.reloadData()
            self?.stopLoading()
        }) { (error) in
            self.resetCollectionView()
            self.stopLoading()
            self.displayMessage(error.rawValue)
            self.filterEnabled(false)
        }
    }

    private func filterEnabled(_ isEnabled: Bool) {
        leftbarButton.isEnabled = isEnabled
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// CollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let object = objects[indexPath.row]
        
        if let artist = object as? Artist {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "similarCell", for: indexPath) as? SimilarCollectionViewCell else { return UICollectionViewCell() }
            cell.setupCellWith(artist)
            return cell
        }
        
        if let album = object as? Album {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topAlbumCell", for: indexPath) as? TopAlbumCollectionViewCell else { return UICollectionViewCell() }
            cell.setupCellWith(album)
            return cell
        }
        
        if let track = object as? Track {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topTracksCell", for: indexPath) as? ToptracksCollectionViewCell else { return UICollectionViewCell() }
            cell.setupCellWith(track)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.9 , height: self.view.frame.height / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let object = objects[indexPath.row]
        if let artist = object as? Artist {
            let cell = cell as? SimilarCollectionViewCell
            cell?.match(artist)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openDetail(objects[indexPath.row])
    }

}

// Search delegate
extension ViewController: SearchDelegate {

    func didSearch(_ searchString: String, method: SearchMethods) {
        objects = []
        collectionView.reloadData()
        resetCollectionView()
        startLoading()
        search(searchString, method: method)
    }
    
    private func startLoading() {
        collectionView.insertSubview(activityView, at: 0)
    }
    
    private func stopLoading() {
        activityView.removeFromSuperview()
    }
    
    private func resetCollectionView() {
        collectionView.reset()
    }
    
    private func displayMessage(_ message: String) {
        self.collectionView.dislpayEmptyWith(message)
    }
    
}

// Filter delegate

extension ViewController: FilterDelegate {
   
    func didFilter(_ by: Filter) {
        guard let object = objects.first else { return }
        
        if let artist = object as? Artist {
            filter(artist, type: by)
        }
        
        if let album = object as? Album {
            filter(album, type: by)
        }
        
        if let track = object as? Track {
            filter(track, type: by)
        }
    
        collectionView.reloadData()
    }
    
    func filter(_ by: Artist, type: Filter) {
        guard let filter = type as? FilterArtist else { return }
        switch filter {
        case .name:
            objects = (objects as! [Artist]).sorted {  return $0.name < $1.name }
        case .match:
            objects = (objects as! [Artist]).sorted {  return $0.match > $1.match }
        }
    }
    
    func filter(_ by: Album, type: Filter) {
        
    }
    
    func filter(_ by: Track, type: Filter) {
        guard let filter = type as? FilterTrack else { return }
        switch filter {
        case .playCount:
            objects = (objects as! [Track]).sorted(by: { (lhs, rhs) -> Bool in
                guard let lhp = lhs.playcount, let rhp = rhs.playcount else { return false }
                return lhp > rhp
            })
        case .rank:
            objects = (objects as! [Track]).sorted {  return $0.rank < $1.rank }
        case .name:
            objects = (objects as! [Track]).sorted {  return $0.name < $1.name }
        }
    }

}

// Navigation
extension ViewController {
    
    @objc private func openSearch() {
        let searchModal = SearchViewController()
        searchModal.delegate = self
        searchModal.modalPresentationStyle = .overCurrentContext
        searchModal.modalTransitionStyle = .crossDissolve
        present(searchModal, animated: true, completion: nil)
    }
    
    @objc private func openFilter() {
        let filterModal = FilterViewController()
        filterModal.delegate = self
        filterModal.transitioningDelegate = transitionManager
        filterModal.modalPresentationStyle = .custom
        filterModal.currentMethod = currentMethod
        present(filterModal, animated: true, completion: nil)
    }
    
    func openDetail(_ item: Any) {
        let detailsController = DetailsViewController()
        detailsController.item = item
        navigationController?.pushViewController(detailsController, animated: true)
    }
}
