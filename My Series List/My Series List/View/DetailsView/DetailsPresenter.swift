//
//  DetailsViewPresenter.swift
//  My Series List
//
//  Created by Ivan Dias on 29/11/2021.
//

import Foundation

protocol DetailsView: NSObjectProtocol {
    
    func listDetails(details: Details)
}

class DetailsPresenter {
    
    var detailsView: DetailsView?
    let seriesRepository = SeriesRepository()
    
    func getDetails(id: Int32) {
        seriesRepository.searchSeriesDetails(id: id) { [self] results in
            switch results {
            case .failure(let error):
                break
            case .success(let details):
                detailsView?.listDetails(details: details)
            }
        }
    }
}
