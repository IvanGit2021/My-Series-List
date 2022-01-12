//
//  SeriesModel.swift
//  My Series List
//
//  Created by Ivan Dias on 18/11/2021.
//

import Foundation

enum Api {
    
    class Results: Codable {
        let results: [Series]
    }
    
    class Name: Codable {
        let name: String?
    }
    
    class Series: Codable {
        var id: Int32?
        var name: String?
        var genres: [Name]?
        var overView: String?
        var numberOfSeasons: Int?
        var originalLanguage: String?
        var homePage: String?
        var backdropPath: String?
        var posterPath: String?
        var isSaved: Bool = false
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case genres
            case overView = "overview"
            case numberOfSeasons = "number_of_seasons"
            case originalLanguage = "original_language"
            case homePage = "homepage"
            case backdropPath = "backdrop_path"
            case posterPath = "poster_path"
        }
    }
}

