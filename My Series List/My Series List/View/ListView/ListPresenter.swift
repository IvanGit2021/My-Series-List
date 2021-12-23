//
//  Presenter.swift
//  My Series List
//
//  Created by Ivan Dias on 24/11/2021.
//

import Foundation
import UIKit

protocol ListView: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func listSeries(_ series: [Series])
    func listError(_ error: Error)
    func listEmpty()
}

class ListPresenter: NSObject {
    
    var listView: ListView?
    let seriesRepository = SeriesRepository()
    var isChecked = true
    var series: [Series] = []
    
    func getSeries() {
        seriesRepository.getSeries(completionHandler: { coreDataSeries in
            switch coreDataSeries {
            case .failure(let error):
                self.listView?.listError(error)
            case .success(let coreDataSeries):
                self.series = coreDataSeries
                if self.series.isEmpty {
                    self.listView?.listEmpty()
                }
                self.listView?.startLoading()
                self.listView?.listSeries(self.series)
                self.listView?.finishLoading()
            }
        })
    }
    
    func deleteSeries(series: Series) {
        seriesRepository.deleteSeries(series: series) { results in
        }
    }
    
    func changeListCheckMark(_ checkMark: UIButton) {
        if isChecked {
            checkMark.setImage(UIImage(systemName: "checkmark.rectangle"), for: .normal)
            isChecked = false
            
        } else {
            checkMark.setImage(UIImage(systemName: "checkmark.rectangle.fill"), for: .normal)
            isChecked = true
        }
    }
    
    func reloadCollectionView(series: [Series], collectionView: UICollectionView) {
        if series.count == 0 {
            listView?.listEmpty()
        }
        collectionView.reloadData()
    }
}



