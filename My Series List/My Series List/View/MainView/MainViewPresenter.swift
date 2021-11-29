//
//  Presenter.swift
//  My Series List
//
//  Created by Ivan Dias on 24/11/2021.
//

import Foundation

protocol MainViewDelegate: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func listSeries(_ series: [CoreDataSeries])
    func listEmpty()
}

class MainViewPresenter {
    
    var mainViewDelegate: MainViewDelegate?
    let repositoryController = RepositoryController()
    
    func setMainViewDelegate(_ mainViewDelegate: MainViewDelegate?){
        self.mainViewDelegate = mainViewDelegate
    }
    
    func getDataFromRepository() {
        repositoryController.getDataFromRepositoryCoreData(completionHandler: { coreDataSeriesArray in
            if coreDataSeriesArray.count != 0 {
                self.mainViewDelegate?.startLoading()
                self.mainViewDelegate?.listSeries(coreDataSeriesArray)
                self.mainViewDelegate?.finishLoading()
            } else {
                self.mainViewDelegate?.listEmpty()
            }
        })
    }
}
