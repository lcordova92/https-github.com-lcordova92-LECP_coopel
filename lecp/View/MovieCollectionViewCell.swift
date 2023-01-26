//
//  MovieCollectionViewCell.swift
//  lecp
//
//  Created by Luis Eduardo Cordova Pichardo on 25/01/23.
//

import UIKit


class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    func setup(with movie: Movie){
        
            DispatchQueue.global().async {
                self.movieImageView.loadFromUrl(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")")!)
            }
        movieTitleLabel.text = movie.title
        scoreLabel.text = movie.vote_average?.description
        descriptionLabel.text = movie.overview
        releaseDateLabel.text = movie.release_date
    }
    
}
