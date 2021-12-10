//
//  MainViewController.swift
//  My Series List
//
//  Created by Ivan Dias on 18/11/2021.
//

import UIKit

class ListController: UIViewController {
    
    @IBOutlet weak var listEmptyLabel: UILabel!
    let listPresenter = ListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listPresenter.listView = self
        listPresenter.getSeries()
    }
}

extension ListController: ListView {
    
    func startLoading() {
        print("Start Loading")
    }
    
    func finishLoading() {
        print("Finish Loading")
    }
    
    func listSeries(_ coreDataSeries: [Series]) {
        print(coreDataSeries)
    }
    
    func listEmpty(_ error: Error) {
        DispatchQueue.main.async {
            self.listEmptyLabel.text = "Couldn't retreave your data, please try later.\nError: \(error.localizedDescription)"
        }
    }
}
