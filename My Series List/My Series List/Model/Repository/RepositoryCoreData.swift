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
    var uuid = UUID().uuidString

    
   func addSeries() {
       let series = CoreDataSeries(context: context)
       
       series.id = uuid
       series.name = "New Series"
       series.overview = "Great New Series"
       series.poster_path = "www.image.com.jpg"
       series.vote_average = 8.4
       
       do {
           try context.save()
       } catch {
           print(error)
       }
   }
   
   func showSeries() {
       let request: NSFetchRequest<CoreDataSeries> = CoreDataSeries.fetchRequest()
       do {
           coreDataSeriesArray = try context.fetch(request)
       } catch {
           print(error)
       }
   }
   
   func deleteSeries(serie: CoreDataSeries) {
       context.delete(serie)
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
