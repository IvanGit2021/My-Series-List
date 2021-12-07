//
//  ApiFetchRequest.swift
//  My Series List
//
//  Created by Ivan Dias on 18/11/2021.
//

import Foundation

class SeriesRemoteDataSource {
    
    let url = "https://api.themoviedb.org/3/search/tv?api_key=0fbc13d4f4bb3dcc23cb30a1a289d426&language=en-US&page=1&include_adult=false&query="
    
    func getData(search: String, completionHandler: @escaping (Result<Results, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: URL (string: url + search )!, completionHandler: { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
            } else if let data = data {
                do {
                    let series = try JSONDecoder().decode(Results.self, from: data)
                    completionHandler(.success(series))
                } catch {
                    completionHandler(.failure(error))
                }
            }
        })
        task.resume()
    }
}
