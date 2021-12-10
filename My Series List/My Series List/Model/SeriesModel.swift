//
//  SeriesModel.swift
//  My Series List
//
//  Created by Ivan Dias on 18/11/2021.
//

import Foundation

enum Api {
    
    struct Results: Codable {
        let results: [Series]
    }
    
    struct Series: Codable {
        let id: Int?
        let name: String?
        let overview: String?
        let posterPath: String?
        let voteAverage: Double?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case overview
            case posterPath = "poster_path"
            case voteAverage = "vote_average"
        }
    }
}

