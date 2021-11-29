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
    }
}

extension MainViewController {
    
    func startLoading() {
        print("Start Loading")
    }
    
    func finishLoading() {
        print("Finish Loading")
    }
    
    func listSeries(_ series: [CoreDataSeries]) {
        series.forEach { coreDataSeriesArray in
            printContent(coreDataSeriesArray)
        }
    }
    
    func listEmpty() {
        print("No data found")
    }
}
