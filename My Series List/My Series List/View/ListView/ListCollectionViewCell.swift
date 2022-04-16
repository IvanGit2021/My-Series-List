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
    var indexPath: IndexPath!
}
