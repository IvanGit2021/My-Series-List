//
//  DetailsViewPresenter.swift
//  My Series List
//
//  Created by Ivan Dias on 29/11/2021.
//

import Foundation

protocol DetailsView: NSObjectProtocol {
    
    func listDetails(details: Api.Series)
    func listDetailsCoreData(details: Series)
    func showEmpty()
    func updateFavourites()
}

class DetailsPresenter {
    
    var detailsView: DetailsView?
    let seriesRepository = SeriesRepository()
    var id: Int32?
    var details: Api.Series?
   
    func insertRemove(isSaved: Bool) {
        if isSaved {
            seriesRepository.getSeriesById(id: id!) { results in
                switch results {
                case .success(let series):
                    self.seriesRepository.deleteSeries(series: series[0]) { results in
                    }
                case .failure(_):
                    break
                }
            }
            self.detailsView!.updateFavourites()
        } else {
            details?.isSaved = true
            seriesRepository.insertSeries(series: details!)
            detailsView?.updateFavourites()
        }
    }
    
    func getDetails(id: Int32) {
        self.id = id
        seriesRepository.searchSeriesDetails(id: id) { [self] results in
            switch results {
            case .success(let details):
                self.details = details
                detailsView?.listDetails(details: details)
            case .failure(_):
                DispatchQueue.main.async {
                    seriesRepository.getSeriesById(id: id) { results in
                        switch results {
                        case .success(let series):
                            if !series.isEmpty {
                                detailsView?.listDetailsCoreData(details: series[0])
                            } else {
                                detailsView?.showEmpty()
                            }
                        case .failure(_):
                            break
                        }
                    }
                }
            }
        }
    }
}
