//
//  DetailsViewController.swift
//  My Series List
//
//  Created by Ivan Dias on 18/11/2021.
//

import UIKit
import Kingfisher

class DetailsController: UIViewController {

    @IBOutlet weak var detailsBackgroundImage: UIImageView!
    @IBOutlet weak var detailsFrontImage: UIImageView!
    @IBOutlet weak var detailsTitle: UILabel!
    @IBOutlet weak var detailsGenre: UILabel!
    @IBOutlet weak var detailsSeasons: UILabel!
    @IBOutlet weak var detailsLanguage: UILabel!
    @IBOutlet weak var detailsOverview: UILabel!
    @IBOutlet weak var detailsWebSite: UIButton!
    
    let detailsPresenter = DetailsPresenter()
    var id: Int32?
    var details: Details?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsPresenter.detailsView = self
        detailsPresenter.getDetails(id: id!)
    }
    
    @IBAction func goToWebsite(_ sender: UIButton) {
        let homePage = details?.homePage == "" ? "https://www.netflix.com" : details?.homePage
        UIApplication.shared.open(URL(string: (homePage)!)! as URL)
    }
}

extension DetailsController: DetailsView {
    
    func listDetails(details: Details) {
        self.details = details
        DispatchQueue.main.async { [self] in
            let imageUrl = URL(string: details.backdropPath == nil ? "" : "https://image.tmdb.org/t/p/w500" + details.backdropPath!)
            let imageUrl2 = URL(string: details.posterPath == nil ? "" : "https://image.tmdb.org/t/p/w500" + details.posterPath!)
            var allGenres = ""
            for name in details.genres! {
                allGenres += name.name! + " "
            }
            
            detailsBackgroundImage.kf.setImage(with: imageUrl)
            detailsFrontImage.kf.setImage(with: imageUrl2)
            detailsTitle.text = details.name
            detailsGenre.text = allGenres
            detailsSeasons.text = details.numberOfSeasons?.description
            detailsLanguage.text = details.originalLanguage?.uppercased()
            detailsOverview.text = details.overView
        }
    }
}
