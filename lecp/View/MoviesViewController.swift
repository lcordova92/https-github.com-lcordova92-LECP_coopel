//
//  MoviesViewController.swift
//  lecp
//
//  Created by Luis Eduardo Cordova Pichardo on 25/01/23.
//

import UIKit
import SkeletonView

class MoviesViewController: UIViewController, MoviesPresenterDelegate {
    
    private let presenter = MoviesPresenter()
    private var movies = [Movie]()
    private var rowToDetail = 0
    
    @IBOutlet var collectionView: UICollectionView!
    
    func getMovies(movies: moviesResponse) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.movies = movies.results
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionView.reloadData()

        presenter.setViewDelegate(delegate: self)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        presenter.getPopularMovies()
    }
    @IBAction func goToAirToday(_ sender: Any) {
        presenter.getAiringTodayMovies()
    }
    
    @IBAction func goToPopular(_ sender: Any) {
        presenter.getPopularMovies()
    }
    @IBAction func goToOnTv(_ sender: Any) {
        presenter.getOnTvMovies()
    }
    @IBAction func goToTopRated(_ sender: Any) {
        presenter.getTopRatedMovies()
    }
    
    @IBAction func openMenu(_ sender: Any) {
        let alert = UIAlertController(title: "Title", message: "What do you wan to do?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "View Profile", style: .default , handler:{ (UIAlertAction)in
            print("User click Approve button")
        }))
        

        alert.addAction(UIAlertAction(title: "Log out", style: .destructive , handler:{ (UIAlertAction)in
            
            self.performSegue(withIdentifier: "goToLI", sender: self.getTopMostViewController())
            self.dismiss(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            alert.dismiss(animated: true)
        }))

        
        //uncomment for iPad Support
        //alert.popoverPresentationController?.sourceView = self.view

        self.present(alert, animated: true, completion: nil)
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToDetail"){
            let vc = segue.destination as! DetailViewController
            vc.movie = movies[rowToDetail]
            
        }
    }*/
    
    func getTopMostViewController() -> UIViewController? {
        var topMostViewController = UIApplication.shared.windows[0].rootViewController

            while let presentedViewController = topMostViewController?.presentedViewController {
                topMostViewController = presentedViewController
            }

            return topMostViewController
        }
    
    
}

extension MoviesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        cell.movieImageView.isSkeletonable = true
        let gradient = SkeletonGradient(baseColor: UIColor.greenSea)
        cell.movieImageView.showAnimatedGradientSkeleton(usingGradient: gradient)
        cell.setup(with: movies[indexPath.row ])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        rowToDetail = indexPath.row
       // performSegue(withIdentifier: "goToDetail", sender: nil)
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 300)
    }
}
