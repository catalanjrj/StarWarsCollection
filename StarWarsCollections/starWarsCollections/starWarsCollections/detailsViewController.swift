//
//  detailsViewController.swift
//  starWarsCollections
//
//  Created by Jorge Catalan on 8/12/16.
//  Copyright © 2016 Jorge Catalan. All rights reserved.
//

import UIKit

class detailsViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var recieved: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = ""
    }
}

