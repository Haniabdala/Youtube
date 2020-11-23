//
//  ViewController.swift
//  Youtube
//
//  Created by Hani Abdallah on 11/19/20.
//

import UIKit

class ViewController: UIViewController {

    var model = Model()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        model.getVideos()
      
    }


}

