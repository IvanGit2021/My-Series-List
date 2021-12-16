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
    func listEmpty(_ error: Error)
}

class SearchPresenter {
    
    var searchView: SearchView?
    let seriesRepository = SeriesRepository()
    var isChecked = true
    
    func searchSeries(search: String) {
        let replacedText = search.replacingOccurrences(of: " ", with: "+")
        seriesRepository.searchSeries(search: replacedText, completionHandler: { series in
            switch series {
            case .failure(let error):
                print(error.localizedDescription)
                self.searchView?.listEmpty(error)
            case .success(let series):
                self.searchView?.startLoading()
                let sortedSeries = series.results.sorted(by: { $0.title! < $1.title! })
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
