//
//  DetailViewController.swift
//  lecp
//
//  Created by Luis Eduardo Cordova Pichardo on 26/01/23.
//

import UIKit
import SkeletonView

class DetailViewController: UIViewController {

    var movie: Movie = Movie()
    
    @IBOutlet var restrictionLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var popularityLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var navigationBar: UINavigationItem!
    @IBOutlet var backItemButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.title = "\(String(describing: movie.title!))"
        
        overviewLabel.text = movie.overview
        titleLabel.text = movie.title!
        popularityLabel.text = movie.popularity!.description
        releaseDateLabel.text = movie.release_date!
        
        if(movie.adult!){
            restrictionLabel.text = "+18"
        }else{
            restrictionLabel.text = "Familiar"
        }
        
        movieImageView.isSkeletonable = true
        let gradient = SkeletonGradient(baseColor: UIColor.greenSea)
        movieImageView.showAnimatedGradientSkeleton(usingGradient: gradient)
        
        DispatchQueue.global().async {
            self.movieImageView.loadFromUrl(url: URL(string: "https://image.tmdb.org/t/p/w500\(self.movie.poster_path ?? "")")!)
        }
    }
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

}
