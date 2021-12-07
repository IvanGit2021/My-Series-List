//
//  RepositoryController.swift
//  My Series List
//
//  Created by Ivan Dias on 19/11/2021.
//

import Foundation

class SeriesRepository {
    
    let seriesRemoteDataSource = SeriesRemoteDataSource()
    let repositoryCoreData = RepositoryCoreData()
    
    func searchSeries(completionHandler: @escaping (Result<Results, Error>) -> Void) {
        seriesRemoteDataSource.getData(search: "squid") { series in
            completionHandler(series)
        }
    }
    
    func getSeries(completionHandler: @escaping ([CoreDataSeries]) -> Void){
        repositoryCoreData.getSeries { coreDataSeriesArray in
            completionHandler(coreDataSeriesArray)
        }
    }
}
