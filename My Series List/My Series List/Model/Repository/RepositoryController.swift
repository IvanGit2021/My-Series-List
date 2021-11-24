//
//  RepositoryController.swift
//  My Series List
//
//  Created by Ivan Dias on 19/11/2021.
//

import Foundation

class RepositoryController {
    
    let repositoryApi = RepositoryApi()
    let repositoryCoreData = RepositoryCoreData()
    var seriesArrayFromApi = [Series]()
    var seriesArrayFromCoreData = [CoreDataSeries]()
    
    func getDataFromRepositoryApi() -> [Series] {
        repositoryApi.getData(search: "squid") { seriesArray in
            self.seriesArrayFromApi = seriesArray
        }
    
        return seriesArrayFromApi
    }
    
    func getDataFromRepositoryCoreData () -> [CoreDataSeries] {
        seriesArrayFromCoreData = repositoryCoreData.showSeries()
        
        return seriesArrayFromCoreData
    }
}
