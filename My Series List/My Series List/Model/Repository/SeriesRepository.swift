//
//  RepositoryController.swift
//  My Series List
//
//  Created by Ivan Dias on 19/11/2021.
//

import Foundation

class SeriesRepository {
    
    let seriesRemoteDataSource = SeriesRemoteDataSource()
    let repositoryCoreData = SeriesLocalDataSource()
    
    func searchSeries(search: String, completionHandler: @escaping (Result<Api.Results, Error>) -> Void) {
        seriesRemoteDataSource.getData(search: search) { series in
            completionHandler(series)
        }
    }
    
    func getSeries(completionHandler: @escaping (Result<[Series], Error>) -> Void){
        repositoryCoreData.getSeries { coreDataSeries in
            completionHandler(coreDataSeries)
        }
    }
}
