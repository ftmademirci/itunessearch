//
//  itunessearchTests.swift
//  itunessearchTests
//
//  Created by Admin on 21.06.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import XCTest
@testable import itunessearch

class itunessearchTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// test iTunes Search API results
    func testITunesSearchApiSearch() throws {
        let expectation = self.expectation(description: "search must be return data array")
        
        iTunesSearchAPI().search(query: "The Hateful Eight", entity: .movie) { (response, error) in
            if let response = response {
                let resultArray = response.results!
                let row = resultArray[0]
                XCTAssertEqual(row.name, "The Hateful Eight")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 4.0) // wait for async request
    }

}
