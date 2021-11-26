//
//  MainViewController.swift
//  My Series List
//
//  Created by Ivan Dias on 18/11/2021.
//

import UIKit

class MainViewController: UIViewController, MainViewDelegate {
    
    let mainViewPresenter = MainViewPresenter()
    let repositoryCoreData = RepositoryCoreData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainViewPresenter.setMainViewDelegate(self)
        repositoryCoreData.showSeries()

    }
}

extension MainViewController {
    
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
