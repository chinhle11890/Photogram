//
//  PageItemViewController.swift
//  Photogram
//
//  Created by Chinh Le on 9/22/16.
//  Copyright © 2016 Chinh Le. All rights reserved.
//

import UIKit

class PageItemViewController: UIViewController {
    // MARK: - Variables
    var itemIndex: Int = 0
    @IBOutlet weak var backgroundImage: UIImageView?
    @IBOutlet weak var descriptionLabel: UILabel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
