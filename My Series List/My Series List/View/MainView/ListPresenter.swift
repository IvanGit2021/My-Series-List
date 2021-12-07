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
    func listEmpty()
}

class ListPresenter {
    
    var listView: ListView?
    let seriesRepository = SeriesRepository()
    
    func setMainViewDelegate(_ mainViewDelegate: ListView?){
        self.listView = mainViewDelegate
    }
    
    func getSeries() {
        seriesRepository.getSeries(completionHandler: { coreDataSeriesArray in
            if coreDataSeriesArray.count != 0 {
                self.listView?.startLoading()
                self.listView?.listSeries(coreDataSeriesArray)
                self.listView?.finishLoading()
            } else {
                self.listView?.listEmpty()
            }
        })
    }
}
