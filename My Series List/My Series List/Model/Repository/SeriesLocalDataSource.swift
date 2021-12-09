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
   
    var coreDataSeriesArray = [CoreDataSeries]()
    
    func insertSeries(series: CoreDataSeries, completionHandler: @escaping (Result<String, Error>) -> Void) {
        let newSeries = CoreDataSeries(context: context)
        
        newSeries.id = series.id
        newSeries.name = series.name
        newSeries.overview = series.overview
        newSeries.posterPath = series.posterPath
        newSeries.voteAverage = series.voteAverage
        
        do {
            try context.save()
            completionHandler(.success("Sucessfully Saved"))
        } catch {
            completionHandler(.failure(error))
        }
    }
    
    func getSeries(completionHandler: @escaping (Result<[CoreDataSeries], Error>) -> Void) {
        let request: NSFetchRequest<CoreDataSeries> = CoreDataSeries.fetchRequest()
        do {
            coreDataSeriesArray = try context.fetch(request)
            completionHandler(.success(coreDataSeriesArray))
        } catch {
            completionHandler(.failure(error))
        }
    }
   
    func deleteSeries(series: CoreDataSeries, completionHandler: @escaping (Result<String, Error>) -> Void) {
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
