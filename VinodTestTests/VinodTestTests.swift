//
//  VinodTestTests.swift
//  VinodTestTests
//
//  Created by mac on 28/03/20.
//  Copyright © 2020 JournalDev.com. All rights reserved.
//

import XCTest
@testable import VinodTest

class VinodTestTests: XCTestCase {
   
  override func setUp() {
      // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
   
  }
  // test api expectation
     func testFetchdataService() {
           let e = expectation(description: "fetchFacts")
           let service = ApiService()

        service.fetchFacts(with: "") { (FactsResults, error) in
              XCTAssertNil(error, "Error \(error!.localizedDescription)")
                        XCTAssertNotNil(FactsResults, "No rows results found")
                        e.fulfill()
        }
           waitForExpectations(timeout: 7.0, handler: nil)
       }
  func testExample() {
       // This is an example of a functional test case.
       // Use XCTAssert and related functions to verify your tests produce the correct results.
   }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
