//
//  CoreData.swift
//  My Series List
//
//  Created by Ivan Dias on 19/11/2021.
//

import Foundation
import CoreData
import UIKit

class SeriesLocalDataSource {
   
    var series = [Series]()
    
    func insertSeries(series: Api.Series, completionHandler: @escaping (Result<String, Error>) -> Void) {
        let newSeries = Series(context: context)
        
        newSeries.id = series.id!
        newSeries.name = series.name
        newSeries.overView = series.overView
        newSeries.posterPath = series.posterPath
        newSeries.isSaved = series.isSaved 
        
        do {
            try context.save()
            completionHandler(.success("Sucessfully Saved"))
        } catch {
            completionHandler(.failure(error))
        }
    }
    
    func getSeries(completionHandler: @escaping (Result<[Series], Error>) -> Void) {
        let request: NSFetchRequest<Series> = Series.fetchRequest()
        do {
            series = try context.fetch(request)
            completionHandler(.success(series))
        } catch {
            completionHandler(.failure(error))
        }
    }
    
    func getSeriesById(id: Int32, completionHandler: @escaping (Result<[Series], Error>) -> Void) {
        let request: NSFetchRequest<Series> = Series.fetchRequest()
        request.predicate = NSPredicate(format: "id == '\(id)'")
        do {
            let seriesById = try context.fetch(request)
            completionHandler(.success(seriesById))
        } catch {
            completionHandler(.failure(error))
        }
    }
   
    func deleteSeries(series: Series, completionHandler: @escaping (Result<String, Error>) -> Void) {
        context.delete(series)
        do {
            try context.save()
            completionHandler(.success("Sucessfully Deleted"))
        } catch {
            completionHandler(.failure(error))
        }
    }
}

extension SeriesLocalDataSource{
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
