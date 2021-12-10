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
    func listSeries(_ series: [Series])
    func listEmpty(_ error: Error)
}

class ListPresenter {
    
    var listView: ListView?
    let seriesRepository = SeriesRepository()
   
    func getSeries() {
        seriesRepository.getSeries(completionHandler: { coreDataSeries in
            switch coreDataSeries {
            case .failure(let error):
                print(error.localizedDescription)
                self.listView?.listEmpty(error)
            case .success(let coreDataSeries):
                self.listView?.startLoading()
                self.listView?.listSeries(coreDataSeries)
                self.listView?.finishLoading()
            }
        })
    }
}
