//
//  MoviesPresenter.swift
//  lecp
//
//  Created by Luis Eduardo Cordova Pichardo on 25/01/23.
//

import Foundation
import UIKit

protocol MoviesPresenterDelegate: AnyObject{
    func getMovies(movies: moviesResponse)
}

typealias MoviesPresenterD = MoviesPresenterDelegate & UIViewController

class MoviesPresenter{
    
    weak var delegate: MoviesPresenterD?
    
    public func getPopularMovies(){
        caller(action: "movie/popular")
    }
    public func getTopRatedMovies(){
        caller(action: "movie/top_rated")
    }
    public func getOnTvMovies(){
        caller(action: "movie/now_playing")
    }
    public func getAiringTodayMovies(){
        caller(action: "tv/airing_today")
    }
    
    public func caller(action: String){
        
        let url = URL(string: "https://api.themoviedb.org/3/\(action)?api_key=385ffc860064978de0a4bdc0eb37836e&language=en-US&page=1")!
        
        let session = URLSession.shared

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        /*do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }*/
/*
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")*/
        
        let task = session.dataTask(with: request, completionHandler: { [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let response = try JSONDecoder().decode(moviesResponse.self, from: data)
                self?.delegate?.getMovies(movies: response)
            }catch{
                print(error)
            }
        })
        task.resume()
    }
    
    public func setViewDelegate(delegate: MoviesPresenterD ){
        self.delegate = delegate
    }
    
}
