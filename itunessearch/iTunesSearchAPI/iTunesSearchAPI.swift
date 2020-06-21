//
//  iTunesSearchAPI.swift
//  itunessearch
//
//  Created by Admin on 21.06.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

/// iTunes Search API constants
struct Constants {
    static let apiUrl = "https://itunes.apple.com/search"
    static let apiPaginationLimit = 20    
}

/// iTunes Search API, search endpoint callback for data or error
typealias iTunesSearchCallback = (_ data: ResultArray?, _ error: String?) -> Void

/// iTunes Search API protocol
protocol iTunesSearchServicesProvider {
    func search(query: String, entity: Entity, callback: @escaping iTunesSearchCallback)
}

/// iTunes Search API main
class iTunesSearchAPI: iTunesSearchServicesProvider {
    func search(query: String, entity: Entity, callback: @escaping iTunesSearchCallback) {
        /// set request url
        
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url = "\(Constants.apiUrl)?term=\(encodedQuery)&limit=\(Constants.apiPaginationLimit)&media=\(entity.type)"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        /// start loader
        Spinner.spin()
        
        AF.request(request).responseJSON { response in
            Spinner.stop()
            switch response.result {
            case .success(let value):
                let data = JSON(value)
                guard let parsedData = Mapper<ResultArray>().map(JSON: data.rawValue as! [String : Any]) else {
                    print("Mapping Error in iTunes Search API!")
                    return
                }
                callback(parsedData, nil)
            case .failure(_):
                let errorCode = response.error?.responseCode ?? 500
                let message = ErrorUtility.errorMessageFor(errorcode: errorCode)
                callback(nil, message)
            }
        }
    }
}
