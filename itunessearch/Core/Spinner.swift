//
//  Spinner.swift
//  itunessearch
//
//  Created by Admin on 21.06.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import NVActivityIndicatorView

/// loading indicator
open class Spinner {
    
    public static let activityData = ActivityData()
    
    public static func spin() {
        NVActivityIndicatorView.DEFAULT_TYPE = .ballScaleRippleMultiple
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.cyan
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    public static func stop() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
