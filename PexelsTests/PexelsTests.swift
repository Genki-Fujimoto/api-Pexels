//
//  PexelsTests.swift
//  PexelsTests
//
//  Created by GENKI Mac on 2021/12/16.
//

import XCTest
@testable import Pexels

class PexelsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //検索結果の個数確認テスト
    func testMySample() {
        
        let ApiList = ApiListModel()
        let expect = expectation(description: "SendMyRequest")
        
        ApiList.searchEvents(keyword: "犬", success: {(api) in
            
            let result = api.photos.count
            print(result)
            
            //0個
            XCTAssertNotEqual(result, 0)
            expect.fulfill()
            
        }, Error:{ (mes) in
            
        })
        
        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                //エラー発生（タイムアウトなど）
                print(error)
                XCTFail("ExpectaionTimeOut")
            } else {
                
            }
        }
    }
    
}
