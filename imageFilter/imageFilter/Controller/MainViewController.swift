//
//  MainViewController.swift
//  imageFilter
//
//  Created by Jin Hou on 23/9/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var myPopUpContainerView: UIView!
    @IBOutlet weak var filterBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        myPopUpContainerView.isHidden = true
        
    }
    
    @IBAction func filterBtnSelected(_ sender: UIButton) {
        
        self.myPopUpContainerView.isHidden = false
        
    }
    
}
