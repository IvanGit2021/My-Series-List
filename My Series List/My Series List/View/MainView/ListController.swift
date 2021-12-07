//
//  MainViewController.swift
//  My Series List
//
//  Created by Ivan Dias on 18/11/2021.
//

import UIKit

class ListController: UIViewController {
    
    let listPresenter = ListPresenter()
    let repositoryCoreData = RepositoryCoreData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listPresenter.setMainViewDelegate(self)
    }
}

extension ListController: ListView {
    
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
