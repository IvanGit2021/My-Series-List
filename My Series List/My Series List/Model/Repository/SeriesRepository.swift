//
//  RepositoryController.swift
//  My Series List
//
//  Created by Ivan Dias on 19/11/2021.
//

import Foundation

class SeriesRepository {
    
    let seriesRemoteDataSource = SeriesRemoteDataSource()
    let seriesLocalDataSource = SeriesLocalDataSource()
    
    func searchSeries(search: String, completionHandler: @escaping (Result<Api.Results, Error>) -> Void) {
        seriesRemoteDataSource.getData(search: search) { results in
            completionHandler(results)
        }
    }
    
    func getSeries(completionHandler: @escaping (Result<[Series], Error>) -> Void){
        seriesLocalDataSource.getSeries { results in
            completionHandler(results)
        }
    }
    
    func deleteSeries(series: Series, completionHandler: @escaping (Result<String, Error>) -> Void) {
        seriesLocalDataSource.deleteSeries(series: series) { results in
            print(results)
        }
    }
    
    func insertSeries(series: Api.Series) {
        seriesLocalDataSource.insertSeries(series: series) { results in
        }
    }
}
