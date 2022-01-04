//
//  SeriesDetailsModel.swift
//  My Series List
//
//  Created by Ivan Dias on 04/01/2022.
//

import Foundation

class Details: Codable {
    let id: Int32?
    let name: String?
    let genres: [Name]?
    let overView: String?
    let numberOfSeasons: Int?
    let originalLanguage: String?
    let homePage: String?
    let backdropPath: String?
    let posterPath: String?
    
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

class Name: Codable {
    let name: String?
}
