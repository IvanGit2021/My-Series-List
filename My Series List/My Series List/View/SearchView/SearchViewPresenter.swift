//
//  SearchViewPresenter.swift
//  My Series List
//
//  Created by Ivan Dias on 29/11/2021.
//

import Foundation

protocol SearchViewDelegate: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func listSeries(_ series: [Series])
    func listEmpty()
}

class SearchViewPresenter {
    
    var searchViewDelegate: SearchViewDelegate?
    let repositoryController = RepositoryController()
    
    func setSearchViewDelegate(_ searchViewDelegate: SearchViewDelegate?){
        self.searchViewDelegate = searchViewDelegate
    }
    
    func getDataFromRepository() {
        repositoryController.getDataFromRepositoryApi(completionHandler: { series in
            if series.count != 0 {
                self.searchViewDelegate?.startLoading()
                self.searchViewDelegate?.listSeries(series)
                self.searchViewDelegate?.finishLoading()
            } else {
                self.searchViewDelegate?.listEmpty()
            }
        })
    }
}
