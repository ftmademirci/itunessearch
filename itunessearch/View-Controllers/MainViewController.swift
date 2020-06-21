//
//  MainViewController.swift
//  itunessearch
//
//  Created by Admin on 21.06.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import UIKit
import SDWebImage

class MainViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var notFoundView: UIView!
    
    var viewModel = SearchResultViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Keyboard
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        self.collectionView.keyboardDismissMode = .onDrag
                
        self.setSearchBar()
        self.setSegmentedControl()
        
        self.searchBar.becomeFirstResponder()
    }
    
    func setSearchBar() {
        searchBar.showsCancelButton = false
        self.definesPresentationContext = true
    }
    
    func setSegmentedControl() {
        self.segmentedControl.removeAllSegments()
        for (entity_key, entity) in Entity.allValues().enumerated() {
            segmentedControl.insertSegment(withTitle: entity, at: entity_key, animated: false)
        }
        self.segmentedControl.selectedSegmentIndex = 0
    }
    
    @IBAction func changedSegmentControl(_ sender: Any) {
        guard !(self.searchBar.text!.count < 3) else {
            return
        }
        self.resetData()
        self.search()
    }
    
    func resetData() {
        self.notFoundView.isHidden = true
        guard self.viewModel.searchData != nil else {
            return
        }
        if var search_data = self.viewModel.searchData!.results {
            search_data.removeAll()
            self.collectionView.reloadData()
        }
    }
    
    @objc func search() {
        if let entity = Entity(rawValue: segmentedControl.selectedSegmentIndex) {
            viewModel.search(searchText: self.searchBar.text!, entity: entity, success: {
                if self.viewModel.numberOfItems() == 0 {
                    self.notFoundView.isHidden = false
                    self.collectionView.isHidden = true
                } else {
                    self.notFoundView.isHidden = true
                    self.collectionView.isHidden = false
                    self.collectionView.reloadData()
                }
            }) { (error) in
                self.notFoundView.isHidden = false
                self.collectionView.isHidden = true
                
            }
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        guard let textToSearch = searchBar.text, !textToSearch.isEmpty else {
            self.searchBar.setShowsCancelButton(true, animated: true)
            return
        }

        guard !(textToSearch.count < 3) else {
            self.resetData()
            return
        }

        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(search), object: nil)
        self.perform(#selector(search), with: nil, afterDelay: 0.5)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(false, animated: true)
        self.definesPresentationContext = true
        self.resetData()
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.openDetailScreen(self.viewModel.row(indexPath.row))
    }
}

extension MainViewController: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iTunesSearchContentCollectionViewCell", for: indexPath) as! iTunesSearchContentCollectionViewCell

        /// reset img
        cell.contentImage.image = nil

        let row = viewModel.row(indexPath.row)

        cell.contentTitle.text = row.name

        let postersURL = row.artworkUrl100?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        cell.contentImage.sd_setImage(with: URL(string: postersURL!))

        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.size.width/2)-20
        return CGSize(width: width, height: (width*0.57)+50) // 9:16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 10, bottom: 0, right: 10)
    }
}
