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
    
    class Series: Codable {
        let id: Int32?
        let name: String?
        let overView: String?
        let posterPath: String?
        let voteAverage: Double?
        var isSaved: Bool = false
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case overView = "overview"
            case posterPath = "poster_path"
            case voteAverage = "vote_average"
        }
    }
}

