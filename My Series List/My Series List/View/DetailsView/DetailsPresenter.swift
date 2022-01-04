//
//  DetailsViewPresenter.swift
//  My Series List
//
//  Created by Ivan Dias on 29/11/2021.
//

import Foundation

protocol DetailsView: NSObjectProtocol {
    
    func listSeries(_ series: [Series])
}

class DetailsPresenter {
    
    var detailsView: DetailsView?
    let seriesRepository = SeriesRepository()
    var seriesID: Int32 = 0
}
