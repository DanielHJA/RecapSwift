//
//  FilterViewController.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-06-04.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

protocol FilterDelegate: class {
    func didFilter(_ by: Filter)
}

class FilterViewController: UIViewController {

    weak var delegate: FilterDelegate?
    var currentMethod: SearchMethods?
    
    private lazy var navBar: UINavigationBar = {
        let temp = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50.0))
        temp.barTintColor = UIColor.black
        temp.isTranslucent = false
        temp.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        let navItem = UINavigationItem(title: "Filter")
        temp.items = [navItem]
        return temp
    }()
    
    private lazy var leftbarButton: UIBarButtonItem = {
        let temp = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(close))
        return temp
    }()
    
    private lazy var rightbarButton: UIBarButtonItem = {
        let temp = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(translateSegmentToFilter))
        return temp
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let temp = UISegmentedControl()
        temp.tintColor = UIColor.black
        temp.backgroundColor = UIColor.clear
        temp.selectedSegmentIndex = 0
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temp.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(navBar)
        navBar.topItem?.leftBarButtonItem = leftbarButton
        navBar.topItem?.rightBarButtonItem = rightbarButton
        setupSegmentedControl()
    }
    
    private func setupSegmentedControl() {
        guard let type = currentMethod else { return }
        switch type {
        case .artist:
            segmentedControl.items(FilterArtist.rawValues)
        case .album:
            break
        case .track:
            segmentedControl.items(FilterTrack.rawValues)
        }
    }
    
    @objc private func translateSegmentToFilter() {
        guard let current = currentMethod else { return }
        let currentSegment = segmentedControl.selectedSegmentIndex
        let filterMethods = current.filterMethods()
        delegate?.didFilter(filterMethods![currentSegment])
        close()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }

}
