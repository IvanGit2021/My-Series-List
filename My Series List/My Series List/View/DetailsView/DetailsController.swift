//
//  DetailsViewController.swift
//  My Series List
//
//  Created by Ivan Dias on 18/11/2021.
//

import UIKit

class DetailsController: UIViewController {

    let detailsPresenter = DetailsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsPresenter.detailsView = self
    }
}

extension DetailsController: DetailsView {
    
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
