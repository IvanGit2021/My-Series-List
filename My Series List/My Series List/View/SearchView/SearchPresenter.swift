//
//  SearchViewPresenter.swift
//  My Series List
//
//  Created by Ivan Dias on 29/11/2021.
//

import Foundation

protocol SearchView: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func listSeries(_ series: Results)
    func listEmpty(_ error: Error)
}

class SearchPresenter {
    
    var searchView: SearchView?
    let seriesRepository = SeriesRepository()
    
    func setSearchViewDelegate(_ searchViewDelegate: SearchView?){
        self.searchView = searchViewDelegate
    }
    
    func searchSeries() {
        seriesRepository.searchSeries(completionHandler: { series in
            switch series {
            case .failure(let error):
                print(error.localizedDescription)
                self.searchView?.listEmpty(error)
            case .success(let series):
                self.searchView?.startLoading()
                self.searchView?.listSeries(series)
                self.searchView?.finishLoading()
            }
         })
    }
}
