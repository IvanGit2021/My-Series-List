//
//  ApiFetchRequest.swift
//  My Series List
//
//  Created by Ivan Dias on 18/11/2021.
//

import Foundation

class RepositoryApi {
    
    let url = "https://api.themoviedb.org/3/search/tv?api_key=0fbc13d4f4bb3dcc23cb30a1a289d426&language=en-US&page=1&include_adult=false&query="
    
    func getData(search: String, completionHandler: @escaping ([Series]) -> Void) {
        let task = URLSession.shared.dataTask(with: URL (string: url + search )!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("Error")
                
                return
            }
            var seriesData : Results!
            
            do {
                seriesData = try JSONDecoder().decode(Results.self, from: data)
            } catch {
                print(error)
            }
            
            completionHandler(seriesData.results)
        })
        task.resume()
    }
}
