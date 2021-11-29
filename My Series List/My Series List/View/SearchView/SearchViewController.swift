//
//  SearchViewController.swift
//  My Series List
//
//  Created by Ivan Dias on 18/11/2021.
//

import UIKit

class SearchViewController: UIViewController, SearchViewDelegate {
    
    let searchViewPresenter = SearchViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchViewPresenter.setSearchViewDelegate(self)
    }
}

extension SearchViewController {
    
    func startLoading() {
        print("Start Loading")
    }
    
    func finishLoading() {
        print("Finish Loading")
    }
    
    func listSeries(_ series: [Series]) {
        series.forEach { series in
            print(series)
        }
    }
    
    func listEmpty() {
        print("No data found")
    }
}
