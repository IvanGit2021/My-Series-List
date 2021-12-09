//
//  Presenter.swift
//  My Series List
//
//  Created by Ivan Dias on 24/11/2021.
//

import Foundation

protocol ListView: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func listSeries(_ series: [CoreDataSeries])
    func listEmpty(_ error: Error)
}

class ListPresenter {
    
    var listView: ListView?
    let seriesRepository = SeriesRepository()
   
    func getSeries() {
        seriesRepository.getSeries(completionHandler: { coreDataSeriesArray in
            switch coreDataSeriesArray {
            case .failure(let error):
                print(error.localizedDescription)
                self.listView?.listEmpty(error)
            case .success(let coreDataSeriesArray):
                self.listView?.startLoading()
                self.listView?.listSeries(coreDataSeriesArray)
                self.listView?.finishLoading()
            }
        })
    }
}
