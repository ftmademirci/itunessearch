//
//  BaseViewController.swift
//  itunessearch
//
//  Created by Admin on 21.06.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func hideKeyboardOnTap(_ selector: Selector) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func openDetailScreen(_ row: SearchResult) {
        let detailViewController = UIStoryboard.mainStoryboard.detailViewController
        detailViewController.row = row
        self.show(detailViewController, sender: nil)
    }
    
    func formatDate(_ dateString: String, dateFormat: String, dateFormatOutput: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = dateFormatOutput
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
}
