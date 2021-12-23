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
    var sortedSeries: [Api.Series] = []
    
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
                DispatchQueue.main.async {
                    self.checkRepeated(seriesArray: self.series)
                    self.sortedSeries = self.series.sorted(by: { $0.title! < $1.title! })
                    self.searchView?.listSeries(self.sortedSeries)
                }
                self.searchView?.finishLoading()
            }
         })
    }
    
    func changeListCheckMark(_ checkMark: UIButton, indexPath: IndexPath) {
        if sortedSeries[indexPath.row].isSaved == false {
            checkMark.setImage(UIImage(systemName: "checkmark.rectangle.fill"), for: .normal)
            seriesRepository.insertSeries(series: sortedSeries[indexPath.row])
            sortedSeries[indexPath.row].isSaved = true
        } else {
            checkMark.setImage(UIImage(systemName: "checkmark.rectangle"), for: .normal)
            sortedSeries[indexPath.row].isSaved = false
            seriesRepository.getSeries { results in
                switch results {
                case .failure(_):
                    break
                case .success(let coreDataSeries):
                    for series in coreDataSeries {
                        if series.id == self.sortedSeries[indexPath.row].id {
                            self.seriesRepository.deleteSeries(series: series) { results in
                            }
                        }
                    }
                }
            }
        }
    }
    
    func checkRepeated(seriesArray: [Api.Series]) {
        seriesRepository.getSeries { results in
            switch results {
            case .failure(_):
                break
            case .success(let coreDataSeries):
                for seriesA in coreDataSeries {
                    for seriesB in seriesArray {
                        if seriesA.id == seriesB.id! {
                            seriesB.isSaved = true
                        }
                    }
                }
            }
        }
    }
}
