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
        var id: Int32?
        var name: String?
        var overView: String?
        var posterPath: String?
        var isSaved: Bool = false
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case overView = "overview"
            case posterPath = "poster_path"
        }
    }
}

