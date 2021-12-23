//
//  SearchCollectionViewCell.swift
//  My Series List
//
//  Created by Ivan Dias on 15/12/2021.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var searchThumbnail: UIImageView!
    @IBOutlet weak var searchTitle: UILabel!
    @IBOutlet weak var searchCheckMark: UIButton!
    let searchPresenter = SearchPresenter()
    var buttonBinding : ((Any) -> Void)?
    
    @IBAction func searchCheckMarkPressed(_ sender: UIButton) {
        if let btnAction = self.buttonBinding {
            btnAction(self)
        }
    }
}


