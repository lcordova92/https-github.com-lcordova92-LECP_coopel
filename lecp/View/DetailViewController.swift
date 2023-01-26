//
//  DetailViewController.swift
//  lecp
//
//  Created by Luis Eduardo Cordova Pichardo on 26/01/23.
//

import UIKit

class DetailViewController: UIViewController {

    var movie: Movie = Movie()
    
    @IBOutlet var restrictionLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var popularityLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
