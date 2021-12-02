//
//  ViewController.swift
//  projetIOSAnimalyy
//
//  Created by User on 14.11.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func suivantButton(_ sender: UIButton) {
        performSegue(withIdentifier: "mSegue1", sender: sender)
    }
    
}

