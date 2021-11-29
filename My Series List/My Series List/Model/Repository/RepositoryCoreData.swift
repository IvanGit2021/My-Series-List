//
//  CoreData.swift
//  My Series List
//
//  Created by Ivan Dias on 19/11/2021.
//

import Foundation
import CoreData
import UIKit

class RepositoryCoreData {
   
    var coreDataSeriesArray = [CoreDataSeries]()

    func addSeries(id: Int32, name: String, overview: String, poster_path: String, vote_average: Double) {
       let series = CoreDataSeries(context: context)
       
       series.id = id
       series.name = name
       series.overview = overview
       series.poster_path = poster_path
       series.vote_average = vote_average
       
       do {
           try context.save()
       } catch {
           print(error)
       }
   }
   
   func showSeries(completionHandler: @escaping ([CoreDataSeries]) -> Void) {
       let request: NSFetchRequest<CoreDataSeries> = CoreDataSeries.fetchRequest()
           do {
              coreDataSeriesArray = try context.fetch(request)
           } catch {
               print(error)
           }
       completionHandler(coreDataSeriesArray)
   }
   
   func deleteSeries(series: CoreDataSeries) {
       context.delete(series)
       do {
           try context.save()
       } catch {
           print(error)
       }
   }
}

extension RepositoryCoreData{
   
   var context: NSManagedObjectContext {
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
       return appDelegate.persistentContainer.viewContext
   }
}
