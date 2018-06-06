//
//  SearchViewController.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-24.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

protocol SearchDelegate: class {
    func didSearch(_ searchString: String, method: SearchMethods)
}

class SearchViewController: ModalViewController {

    weak var delegate: SearchDelegate?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        let searchView = SearchView(frame: view.bounds)
        searchView.delegate = self
        view.addSubview(searchView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension SearchViewController: SearchViewDelegate {

    func search(_ searchString: String, method: SearchMethods) {
        delegate?.didSearch(searchString, method: method)
    }

    func closeModal() {
        close()
    }
}
