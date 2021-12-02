//
//  pageDeuxViewController.swift
//  projetIOSAnimalyy
//
//  Created by User on 30.11.2021.
//

import UIKit

class PageLivrerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func suivantButton(_ sender: UIButton) {
        performSegue(withIdentifier: "mSegue2", sender: sender)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
