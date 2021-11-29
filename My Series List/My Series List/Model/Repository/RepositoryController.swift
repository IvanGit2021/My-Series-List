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
    var seriesArrayFromCoreData = [CoreDataSeries]()
    
    func getDataFromRepositoryApi(completionHandler: @escaping ([Series]) -> Void) {
        repositoryApi.getData(search: "squid") { series in
            completionHandler(series)
        }
    }
    
    func getDataFromRepositoryCoreData(completionHandler: @escaping ([CoreDataSeries]) -> Void){
        repositoryCoreData.showSeries { coreDataSeriesArray in
            completionHandler(coreDataSeriesArray)
        }
    }
}
