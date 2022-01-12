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
    func setSavedToTrue()
    func setSavedToFalse()
}

class DetailsPresenter {
    
    var detailsView: DetailsView?
    let seriesRepository = SeriesRepository()
    var id: Int32?
    var details: Api.Series?
   
    func insertRemove(isSaved: Bool) {
        if isSaved {
            seriesRepository.getSeries { results in
                switch results {
                case .failure(_):
                    break
                case .success(let series):
                    for series in series {
                        if series.id == self.id {
                            self.seriesRepository.deleteSeries(series: series) { results in
                            }
                            break
                        }
                    }
                    self.detailsView!.setSavedToFalse()
                }
            }
        } else {
            let series = Api.Series()
            series.id = details!.id
            series.name = details!.name
            series.overView = details!.overView
            series.posterPath = details!.posterPath
            series.isSaved = true
            seriesRepository.insertSeries(series: series)
            detailsView?.setSavedToTrue()
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
                    seriesRepository.getSeries { results in
                        switch results {
                        case (.failure(_)):
                            break
                        case (.success(let seriesCoreData)):
                        var count = 0
                            for series in seriesCoreData {
                                if series.id == id {
                                    let details = series
                                    detailsView?.listDetailsCoreData(details: details)
                                    count += 1
                                    break
                                }
                            }
                            if count == 0 {
                                detailsView?.showEmpty()
                            }
                        }
                    }
                }
            }
        }
    }
}
