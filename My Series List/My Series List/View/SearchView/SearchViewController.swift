//
//  SearchViewController.swift
//  My Series List
//
//  Created by Ivan Dias on 18/11/2021.
//

import UIKit

class SearchViewController: UIViewController, SearchViewDelegate {
    
    @IBOutlet weak var listEmptyLabel: UILabel!
    let searchViewPresenter = SearchViewPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchViewPresenter.setSearchViewDelegate(self)
        searchViewPresenter.getDataFromRepository()
    }
}

extension SearchViewController {
    
    func startLoading() {
        print("Start Loading")
    }
    
    func finishLoading() {
        print("Finish Loading")
    }
    
    func listSeries(_ series: Results) {
        print(series.results)
    }
    
    func listEmpty(_ error: Error) {
        DispatchQueue.main.async {
            self.listEmptyLabel.text = "Couldn't retreave your data, please try later.\nError: \(error.localizedDescription)"
        }
    }
}
