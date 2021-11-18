//
//  ApiFetchRequest.swift
//  My Series List
//
//  Created by Ivan Dias on 18/11/2021.
//

import Foundation

class ApiFetchRequest {
    
    let url = "https://api.themoviedb.org/3/search/tv?api_key=0fbc13d4f4bb3dcc23cb30a1a289d426&language=en-US&page=1&query=game&include_adult=false"
    
    func getData(from url: String){
        let task = URLSession.shared.dataTask(with: URL (string: url)!, completionHandler: { data, response, error in
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
        })
        task.resume()
    }
}
