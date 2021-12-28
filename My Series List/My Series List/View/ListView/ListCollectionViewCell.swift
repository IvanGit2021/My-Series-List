//
//  ListCollectionViewCell.swift
//  My Series List
//
//  Created by Ivan Dias on 10/12/2021.
//

import UIKit

protocol ListCell {
    func listButtonPressed(at indexPath: IndexPath)
}

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var listThumbnail: UIImageView!
    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var listCheckMark: UIButton!
    let listPresenter = ListPresenter()
    var listCell: ListCell?
    var indexPath: IndexPath!

    @IBAction func listCheckMarkPressed(_ sender: UIButton) {
        self.listCell?.listButtonPressed(at: indexPath)
    }
}
