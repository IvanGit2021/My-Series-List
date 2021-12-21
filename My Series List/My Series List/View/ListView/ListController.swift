//
//  MainViewController.swift
//  My Series List
//
//  Created by Ivan Dias on 18/11/2021.
//

import UIKit
import Kingfisher

class ListController: UIViewController {
    
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    let listPresenter = ListPresenter()
    var series: [Series] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listPresenter.listView = self
        listPresenter.getSeries()
      }
}

extension ListController: ListView {
    
    func startLoading() {
        print("Start Loading")
    }
    
    func finishLoading() {
        print("Finish Loading")
    }
    
    func listSeries(_ series: [Series]) {
        collectionView.dataSource = self
        collectionView.delegate = self
        self.series = series
    }
    
    func listError(_ error: Error) {
        DispatchQueue.main.async {
            self.emptyLabel.text = "Couldn't retrieve your data, please try again later."
            self.emptyLabel.textAlignment = .center
            self.view.addSubview(self.emptyLabel)
        }
    }
    
    func listEmpty() {
        emptyLabel.text = "The List is Empty, please insert some Series."
        emptyLabel.textAlignment = .center
        view.addSubview(emptyLabel)
    }
}

extension ListController: UICollectionViewDataSource, UICollectionViewDelegate {
 
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return series.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + series[indexPath.row].posterPath!)
        let processor = RoundCornerImageProcessor(cornerRadius: 10)

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as! ListCollectionViewCell
        cell.listTitle.text = series[indexPath.row].title
        cell.listThumbnail.kf.setImage(with: url, options: [.processor(processor)])
        cell.listCheckMark.setImage(UIImage(systemName: "checkmark.rectangle.fill"), for: .normal)
        cell.buttonBinding = { [self] in
            listPresenter.deleteSeries(series: series[indexPath.row])
            series.remove(at: indexPath.row)
            collectionView.reloadData()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(series[indexPath.row])
    }
}
