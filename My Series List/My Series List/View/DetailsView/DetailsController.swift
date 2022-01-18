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
    @IBOutlet weak var detailsSeasonsLabel: UILabel!
    @IBOutlet weak var detailsSeasons: UILabel!
    @IBOutlet weak var detailsLanguageLabel: UILabel!
    @IBOutlet weak var detailsLanguage: UILabel!
    @IBOutlet weak var detailsOverview: UILabel!
    @IBOutlet weak var detailsWebSite: UIButton!
    @IBOutlet weak var emptyDetails: UILabel!
    @IBOutlet weak var detailsSaveDelete: UIButton!
    @IBOutlet weak var detailsFavourites: UIImageView!
    
    let detailsPresenter = DetailsPresenter()
    var id: Int32?
    var isSaved: Bool?
    var details: Api.Series?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsPresenter.detailsView = self
        detailsPresenter.getDetails(id: id!)
    }
    
    @IBAction func saveDelete(_ sender: UIButton) {
        isSaved! ? detailsPresenter.deleteSeries() : detailsPresenter.insertSeries()
    }
    
    @IBAction func goToWebsite(_ sender: UIButton) {
        let homePage = details?.homePage == "" ? "https://www.netflix.com" : details?.homePage
        UIApplication.shared.open(URL(string: (homePage)!)! as URL)
    }
}

extension DetailsController: DetailsView {
   
    func listDetails(details: Api.Series) {
        self.details = details
        DispatchQueue.main.async { [self] in
            emptyDetails.isHidden = true
            let imageUrl = URL(string: details.backdropPath == nil ? "" : "https://image.tmdb.org/t/p/w500" + details.backdropPath!)
            let imageUrl2 = URL(string: details.posterPath == nil ? "" : "https://image.tmdb.org/t/p/w500" + details.posterPath!)
            if isSaved!{
                detailsSaveDelete.setTitle("Delete", for: .normal)
            } else {
                detailsSaveDelete.setTitle("Save", for: .normal)
                detailsFavourites.isHidden = true
            }
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
    
    func listDetailsCoreData(details: Series) {
        DispatchQueue.main.async { [self] in
            detailsSaveDelete.titleLabel?.text = "Delete"
            emptyDetails.isHidden = true
            let imageUrl = URL(string: details.posterPath == nil ? "" : "https://image.tmdb.org/t/p/w500" + details.posterPath!)
            detailsFrontImage.kf.setImage(with: imageUrl)
            detailsTitle.text = details.name
            detailsGenre.isHidden = true
            detailsSeasonsLabel.isHidden = true
            detailsSeasons.isHidden = true
            detailsLanguageLabel.isHidden = true
            detailsLanguage.isHidden = true
            detailsOverview.text = details.overView
            detailsWebSite.isHidden = true
        }
    }
    
    func showEmpty() {
        DispatchQueue.main.async { [self] in
            detailsFrontImage.isHidden = true
            emptyDetails.isHidden = false
            detailsTitle.isHidden = true
            detailsGenre.isHidden = true
            detailsSeasonsLabel.isHidden = true
            detailsSeasons.isHidden = true
            detailsLanguageLabel.isHidden = true
            detailsLanguage.isHidden = true
            detailsOverview.isHidden = true
            detailsWebSite.isHidden = true
            detailsFavourites.isHidden = true
            detailsSaveDelete.isHidden = true
        }
    }

    func updateFavourites() {
        if isSaved! {
            detailsFavourites.isHidden = true
            detailsSaveDelete.setTitle("Save", for: .normal)
            isSaved = false
        } else {
            detailsFavourites.isHidden = false
            detailsSaveDelete.setTitle("Delete", for: .normal)
            isSaved = true
        }
    }
}
