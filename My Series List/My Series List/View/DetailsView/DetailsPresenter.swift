//
//  DetailsViewPresenter.swift
//  My Series List
//
//  Created by Ivan Dias on 29/11/2021.
//

import Foundation

protocol DetailsView: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func listSeries(_ series: [Series])
    func listEmpty()
}

class DetailsPresenter {
    
    var detailsView: DetailsView?
    let seriesRepository = SeriesRepository()
    var seriesID: Int32 = 0
}
    
    /*func getSeries() {
        seriesRepository.searchSeries(completionHandler: { series in
            if series.count != 0 {
                self.detailsView?.startLoading()
                self.detailsView?.listSeries(series)
                self.detailsView?.finishLoading()
            } else {
                self.detailsView?.listEmpty()
            }
        })
    }*/

