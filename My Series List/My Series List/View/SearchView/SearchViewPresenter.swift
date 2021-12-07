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
    func listSeries(_ series: Results)
    func listEmpty(_ error: Error)
}

class SearchViewPresenter {
    
    var searchViewDelegate: SearchViewDelegate?
    let repositoryController = RepositoryController()
    
    func setSearchViewDelegate(_ searchViewDelegate: SearchViewDelegate?){
        self.searchViewDelegate = searchViewDelegate
    }
    
    func getDataFromRepository() {
        repositoryController.getDataFromRepositoryApi(completionHandler: { series in
            switch series {
            case .failure(let error):
                print(error.localizedDescription)
                self.searchViewDelegate?.listEmpty(error)
            case .success(let series):
                self.searchViewDelegate?.startLoading()
                self.searchViewDelegate?.listSeries(series)
                self.searchViewDelegate?.finishLoading()
            }
         })
    }
}
