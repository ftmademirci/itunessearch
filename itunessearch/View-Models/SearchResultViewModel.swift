//
//  SearchResultViewModel.swift
//  itunessearch
//
//  Created by Admin on 21.06.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import Foundation

class SearchResultViewModel  {
    
    var searchData: ResultArray?

    var api: iTunesSearchAPI!
    
    init() {
        self.api = iTunesSearchAPI()
    }
    
    // search
    func search(searchText: String, entity: Entity, success: @escaping() -> Void,
                failure: @escaping (String?) -> Void) {
        self.api.search(query: searchText, entity: entity) { (response, error) in
            if let error = error {
                failure(error)
            }
            
            if let response = response {
                self.searchData = response
                success()
            }
        }
    }
    
    public func numberOfItems() -> Int {
        return self.searchData?.results?.count ?? 0
    }
    
    public func row(_ index: Int) -> SearchResult {
        return (self.searchData?.results?[index])!
    }
}
