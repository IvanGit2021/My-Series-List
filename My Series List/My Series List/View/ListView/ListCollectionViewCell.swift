//
//  ListCollectionViewCell.swift
//  My Series List
//
//  Created by Ivan Dias on 10/12/2021.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
  
    @IBOutlet weak var listThumbnail: UIImageView!
    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var listCheckMark: UIButton!
    let listPresenter = ListPresenter()
    var buttonBinding : (() -> Void)?

    @IBAction func listCheckMarkPressed(_ sender: UIButton) {
        listPresenter.changeListCheckMark(sender)
        if let btnAction = self.buttonBinding {
            btnAction()
        }
    }
}
