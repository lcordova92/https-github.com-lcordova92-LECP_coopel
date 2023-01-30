//
//  Movie.swift
//  lecp
//
//  Created by Luis Eduardo Cordova Pichardo on 25/01/23.
//

import Foundation

struct moviesResponse: Codable{
    let results: [Movie]
}

struct Movie: Codable{
    
    init() {
        poster_path = ""
        release_date = ""
        title = ""
        vote_average = 0.0
        overview = ""
        adult = false
        popularity = 0.0
    }
    
    let poster_path: String?
    let release_date: String?
    let title: String?
    let vote_average: Float?
    let overview: String?
    let adult: Bool?
    let popularity: Float?
}
