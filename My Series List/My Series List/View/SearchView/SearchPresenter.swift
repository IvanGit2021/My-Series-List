//
//  SearchViewPresenter.swift
//  My Series List
//
//  Created by Ivan Dias on 29/11/2021.
//

import UIKit

protocol SearchView: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func listSeries(_ series: [Api.Series])
    func listError(_ error: Error)
    func listEmpty()
}

class SearchPresenter {
    
    var searchView: SearchView?
    let seriesRepository = SeriesRepository()
    var series: [Api.Series] = []
    var isChecked = true
    
    func searchSeries(search: String) {
        let replacedText = search.replacingOccurrences(of: " ", with: "+")
        seriesRepository.searchSeries(search: replacedText, completionHandler: { apiSeries in
            switch apiSeries {
            case .failure(let error):
                self.searchView?.listError(error)
            case .success(let apiSeries):
                self.series = apiSeries.results
                if self.series.isEmpty {
                    self.searchView?.listEmpty()
                }
                self.searchView?.startLoading()
                let sortedSeries = self.series.sorted(by: { $0.title! < $1.title! })
                self.searchView?.listSeries(sortedSeries)
                self.searchView?.finishLoading()
            }
         })
    }
    
    func changeListCheckMark(_ checkMark: UIButton) {
        if isChecked {
            checkMark.setImage(UIImage(systemName: "checkmark.rectangle.fill"), for: .normal)
            isChecked = false
            
        } else {
            checkMark.setImage(UIImage(systemName: "checkmark.rectangle"), for: .normal)
            isChecked = true
        }
    }
}
