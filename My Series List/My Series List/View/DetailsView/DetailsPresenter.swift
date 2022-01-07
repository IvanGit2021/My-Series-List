//
//  DetailsViewPresenter.swift
//  My Series List
//
//  Created by Ivan Dias on 29/11/2021.
//

import Foundation

protocol DetailsView: NSObjectProtocol {
    
    func listDetails(details: Details)
    func listDetailsCoreData(details: Series)
    func showEmpty()
}

class DetailsPresenter {
    
    var detailsView: DetailsView?
    let seriesRepository = SeriesRepository()
    
    func getDetails(id: Int32) {
        seriesRepository.searchSeriesDetails(id: id) { [self] results in
            switch results {
            case .success(let details):
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
