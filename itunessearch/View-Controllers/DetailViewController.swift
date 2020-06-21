//
//  DetailViewController.swift
//  itunessearch
//
//  Created by Admin on 21.06.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {

    var row: SearchResult!
    
    @IBOutlet var artworkImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.artworkImage.sd_setImage(with: URL(string: self.row.artworkUrl100!))
        self.titleLabel.text = self.row.name
        self.priceLabel.text = "\(self.row.storePrice) \(self.row.currency)"
        self.releaseLabel.text = self.formatDate(self.row.releaseDate ?? "", dateFormat: "yyyy-MM-dd'T'HH:mm:ssXXXXX", dateFormatOutput: "yyyy-MM-dd")        
    }
    
    @IBAction func viewOnITunes(_ sender: Any) {
        if let url = URL(string: row.storeUrl) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
