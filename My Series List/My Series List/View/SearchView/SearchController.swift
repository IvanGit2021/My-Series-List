//
//  SearchViewController.swift
//  My Series List
//
//  Created by Ivan Dias on 18/11/2021.
//

import UIKit
import Kingfisher

class SearchController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var listEmptyLabel: UILabel!
    let searchPresenter = SearchPresenter()
    let seriesRepository = SeriesRepository()
    var series: [Api.Series] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchPresenter.searchView = self
        searchPresenter.searchSeries()
    }
}

extension SearchController: SearchView {
    
    func startLoading() {
        print("Start Loading")
    }
    
    func finishLoading() {
        print("Finish Loading")
    }
    
    func listSeries(_ series: [Api.Series]) {
        DispatchQueue.main.async {
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
        }
        self.series = series
        
}
    
    func listEmpty(_ error: Error) {
        DispatchQueue.main.async {
            self.listEmptyLabel.text = "Couldn't retreave your data, please try later.\nError: \(error.localizedDescription)"
        }
    }
}

extension SearchController: UICollectionViewDataSource, UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return series.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let processor = RoundCornerImageProcessor(cornerRadius: 10)

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! SearchCollectionViewCell
        
        cell.searchTitle.text = series[indexPath.row].title
        if series[indexPath.row].posterPath != nil {
            let url = URL(string: "https://image.tmdb.org/t/p/w500" + series[indexPath.row].posterPath!)
            cell.searchThumbnail.kf.setImage(with: url, options: [.processor(processor)])
        } else {
            cell.searchThumbnail.image = UIImage(named: "noImage")        }
        cell.searchCheckMark.setImage(UIImage(systemName: "checkmark.rectangle"), for: .normal)
        cell.searchTitle.text = series[indexPath.row].title
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(series[indexPath.row])
    }
}
     
