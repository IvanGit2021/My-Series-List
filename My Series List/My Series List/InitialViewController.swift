//
//  InitialViewController.swift
//  My Series List
//
//  Created by Macbook on 16/04/2022.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet var yConstraint: NSLayoutConstraint!
    @IBOutlet var enterButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = .systemGray6
        yConstraint.constant -= view.bounds.width
        enterButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        yConstraint.constant = 0
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
    
        enterButton.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0.5, options: []) {
            self.view.layoutIfNeeded()
        }



    }
}
