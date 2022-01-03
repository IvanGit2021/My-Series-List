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
    var seriesSorted: [Api.Series] = []
    
    func searchSeries(search: String) {
        let replacedText = search.replacingOccurrences(of: " ", with: "+")
        seriesRepository.searchSeries(search: replacedText, completionHandler: { results in
            switch results {
            case .failure(let error):
                self.searchView?.listError(error)
            case .success(let seriesApi):
                self.series = seriesApi.results
                if self.series.isEmpty {
                    self.searchView?.listEmpty()
                }
                self.searchView?.startLoading()
                DispatchQueue.main.async {
                    self.checkRepeated(seriesArray: self.series)
                    self.seriesSorted = self.series.sorted(by: { $0.title! < $1.title! })
                    self.searchView?.listSeries(self.seriesSorted)
                }
                self.searchView?.finishLoading()
            }
         })
    }
    
    func changeListCheckMark(_ checkMark: UIButton, indexPath: IndexPath) {
        if seriesSorted[indexPath.row].isSaved == false {
            checkMark.setImage(UIImage(systemName: "checkmark.rectangle.fill"), for: .normal)
            seriesRepository.insertSeries(series: seriesSorted[indexPath.row])
            seriesSorted[indexPath.row].isSaved = true
        } else {
            checkMark.setImage(UIImage(systemName: "checkmark.rectangle"), for: .normal)
            seriesSorted[indexPath.row].isSaved = false
            seriesRepository.getSeries { results in
                switch results {
                case .failure(_):
                    break
                case .success(let seriesCoreData):
                    for series in seriesCoreData {
                        if series.id == self.seriesSorted[indexPath.row].id {
                            self.seriesRepository.deleteSeries(series: series) 
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
            case .success(let seriesCoreData):
                for seriesA in seriesArray {
                    for seriesB in seriesCoreData {
                        if seriesA.id == seriesB.id {
                            seriesA.isSaved = true
                            break
                        }
                    }
                }
            }
        }
    }
}
