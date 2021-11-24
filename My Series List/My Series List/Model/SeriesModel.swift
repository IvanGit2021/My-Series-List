//
//  SeriesModel.swift
//  My Series List
//
//  Created by Ivan Dias on 18/11/2021.
//

import Foundation

struct Results: Codable {
    let results: [Series]
}

struct Series: Codable {
    let name: String?
    let overview: String?
    let poster_path: String?
    let vote_average: Double?
    let id: Int?
}
