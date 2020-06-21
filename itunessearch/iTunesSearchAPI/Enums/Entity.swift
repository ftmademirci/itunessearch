//
//  Entity.swift
//  itunessearch
//
//  Created by Admin on 21.06.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import Foundation

/// iTunes search entity types
enum Entity: Int {
    case movie
    case music
    case software
    case ebooks
    
    var type: String {
        switch self {
        case .movie:
            return "movie"
        case .music:
            return "music"
        case .software:
            return "software"
        case .ebooks:
            return "ebook"
        }
    }
}
