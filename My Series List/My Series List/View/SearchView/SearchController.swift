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
    @IBOutlet weak var emptyLabel: UILabel!
    let searchPresenter = SearchPresenter()
    var series: [Api.Series] = []
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchPresenter.searchView = self
        searchPresenter.searchSeries(search: "")
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        emptyLabel.isHidden = true
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
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func listError(_ error: Error) {
        DispatchQueue.main.async { [self] in
            emptyLabel.text = "Couldn't retreave your data, please try again later.\nError: \(error.localizedDescription)"
            emptyLabel.textAlignment = .center
            view.addSubview(emptyLabel)
            navigationItem.searchController?.isActive = true
            emptyLabel.isHidden = false
        }
    }
    
    func listEmpty() {
        DispatchQueue.main.async { [self] in
            emptyLabel.text = "Please search with another title."
            emptyLabel.isHidden = false
        }
    }
}

extension SearchController: UICollectionViewDataSource, UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return series.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! SearchCollectionViewCell
        
        cell.searchTitle.text = series[indexPath.row].name
        if series[indexPath.row].posterPath != nil {
            let url = URL(string: "https://image.tmdb.org/t/p/w500" + series[indexPath.row].posterPath!)
            cell.searchThumbnail.kf.setImage(with: url)
        } else {
            cell.searchThumbnail.image = UIImage(named: "noImage")
        }
        if series[indexPath.row].isSaved == true {
            cell.searchCheckMark.setImage(UIImage(systemName: "checkmark.rectangle.fill"), for: .normal)
        } else {
            cell.searchCheckMark.setImage(UIImage(systemName: "checkmark.rectangle"), for: .normal)
        }
        cell.buttonBinding = { sender in
            self.searchPresenter.changeListCheckMark(cell.searchCheckMark, indexPath: indexPath)
        }
        cell.searchTitle.text = series[indexPath.row].name
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetails", sender: self)
    }
}

extension SearchController: UISearchBarDelegate{
 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchPresenter.searchSeries(search: text)
        collectionView.reloadData()
        emptyLabel.isHidden = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchPresenter.searchSeries(search: "")
        emptyLabel.isHidden = true
    }
}

    
    
    

     
