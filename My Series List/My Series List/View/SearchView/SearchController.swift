//
//  SearchViewController.swift
//  My Series List
//
//  Created by Ivan Dias on 18/11/2021.
//

import UIKit

class SearchController: UIViewController {
    
    @IBOutlet weak var listEmptyLabel: UILabel!
    let searchPresenter = SearchPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchPresenter.searchView = self
        searchPresenter.searchSeries(search: "game")
    }
}

extension SearchController: SearchView {
    
    func startLoading() {
        print("Start Loading")
    }
    
    func finishLoading() {
        print("Finish Loading")
    }
    
    func listSeries(_ series: Api.Results) {
        print(series.results)
    }
    
    func listEmpty(_ error: Error) {
        DispatchQueue.main.async {
            self.listEmptyLabel.text = "Couldn't retreave your data, please try later.\nError: \(error.localizedDescription)"
        }
    }
}
