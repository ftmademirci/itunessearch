//
//  UIStoryboards+UIViewControllers.swift
//  itunessearch
//
//  Created by Admin on 21.06.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    var detailViewController: DetailViewController {
        guard let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            fatalError("DetailViewController couldn't be found in Storyboard file")
        }
        return vc
    }
}
