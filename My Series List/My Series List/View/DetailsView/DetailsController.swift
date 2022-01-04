//
//  DetailsViewController.swift
//  My Series List
//
//  Created by Ivan Dias on 18/11/2021.
//

import UIKit

class DetailsController: UIViewController {

    let detailsPresenter = DetailsPresenter()
    var id: Int32?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsPresenter.detailsView = self
        detailsPresenter.getDetails(id: id!)
    }
}

extension DetailsController: DetailsView {
    
    func listDetails(details: Details) {
    }
}
