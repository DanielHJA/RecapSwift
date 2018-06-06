//
//  SearchView.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-26.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

protocol SearchViewDelegate: class {
    func search(_ searchString: String, method: SearchMethods)
    func closeModal()
}

class SearchView: UIView {
    
    weak var delegate: SearchViewDelegate?

    private lazy var closeButton: UIButton = {
        let temp = UIButton()
        temp.setTitle("X", for: .normal)
        temp.tintColor = UIColor.white
        temp.titleLabel?.font = UIFont(name: "Helvetica", size: 25.0)
        temp.addTarget(self, action: #selector(close), for: .touchUpInside)
        temp.backgroundColor = UIColor.clear
        return temp
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let temp = UISegmentedControl(items: SearchMethods.allValues)
        temp.tintColor = UIColor.white
        temp.backgroundColor = UIColor.clear
        temp.selectedSegmentIndex = 0
        return temp
    }()
    
    private var searchBar: UITextField = {
        let temp = UITextField()
        temp.backgroundColor = UIColor.clear
        temp.textColor = UIColor.white
        temp.layer.borderColor = UIColor.white.cgColor
        temp.layer.borderWidth = 2.0
        temp.font = UIFont(name: "AvenirNextCondensed-Bold", size: 25.0)
        temp.textAlignment = .center
        return temp
    }()
    
    private lazy var searchButton: UIButton = {
        let temp = UIButton()
        temp.setTitle("Search", for: .normal)
        temp.titleLabel?.textColor = UIColor.white
        temp.backgroundColor = UIColor.clear
        temp.layer.borderColor = UIColor.white.cgColor
        temp.layer.borderWidth = 2.0
        temp.addTarget(self, action: #selector(search), for: .touchUpInside)
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.isOpaque = false
        self.backgroundColor = UIColor.clear
        
        addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        
        addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchBar.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        searchBar.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        segmentedControl.widthAnchor.constraint(equalTo: searchBar.widthAnchor).isActive = true
        segmentedControl.bottomAnchor.constraint(equalTo: searchBar.topAnchor, constant: -10.0).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10.0).isActive = true
        searchButton.widthAnchor.constraint(equalTo: searchBar.widthAnchor).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        searchBar.becomeFirstResponder()
    }
    
    @objc private func search() {
        guard let text = searchBar.text, text.count > 0 else { return }
        let index = segmentedControl.selectedSegmentIndex
        delegate?.search(text.URLEncoded(), method: SearchMethods.caseFromIndex(index))
        delegate?.closeModal()
    }
    
    @objc private func close() {
        delegate?.closeModal()
    }

}
