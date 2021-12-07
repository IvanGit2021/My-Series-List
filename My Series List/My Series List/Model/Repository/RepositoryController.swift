//
//  RepositoryController.swift
//  My Series List
//
//  Created by Ivan Dias on 19/11/2021.
//

import Foundation

class RepositoryController {
    
    let seriesRemoteDataSource = SeriesRemoteDataSource()
    let repositoryCoreData = RepositoryCoreData()
    
    func getDataFromRepositoryApi(completionHandler: @escaping (Result<Results, Error>) -> Void) {
        seriesRemoteDataSource.getData(search: "squid") { series in
            completionHandler(series)
        }
    }
    
    func getDataFromRepositoryCoreData(completionHandler: @escaping ([CoreDataSeries]) -> Void){
        repositoryCoreData.showSeries { coreDataSeriesArray in
            completionHandler(coreDataSeriesArray)
        }
    }
}
