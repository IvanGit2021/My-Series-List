//
//  RepositoryController.swift
//  My Series List
//
//  Created by Ivan Dias on 19/11/2021.
//

import Foundation

class RepositoryController {
    
    let repositoryApi = RepositoryApi()
    var series = [Series]()
    
    func getDataFromRepositoryApi() -> [Series] {
        repositoryApi.getData(search: "squid") { seriesArray in
            self.series = seriesArray
        }
    
        return series
    }
    
    func getDataFromRepositoryCoreData () {
        
    }
}
