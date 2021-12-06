//
//  DetailsViewPresenter.swift
//  My Series List
//
//  Created by Ivan Dias on 29/11/2021.
//

import Foundation

protocol DetailsViewDelegate: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func listSeries(_ series: [Series])
    func listEmpty()
}

class DetailsViewPresenter {
    
    var detailsViewDelegate: DetailsViewDelegate?
    let repositoryController = RepositoryController()
    
    func setDetailsViewDelegate(_ detailsViewDelegate: DetailsViewDelegate?){
        self.detailsViewDelegate = detailsViewDelegate
    }
    
    func getDataFromRepository() {
        repositoryController.getDataFromRepositoryApi(completionHandler: { series in
            if series.count != 0 {
                self.detailsViewDelegate?.startLoading()
                self.detailsViewDelegate?.listSeries(series)
                self.detailsViewDelegate?.finishLoading()
            } else {
                self.detailsViewDelegate?.listEmpty()
            }
        })
    }
}
