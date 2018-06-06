//
//  ModalViewController.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-05-26.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func close() {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
