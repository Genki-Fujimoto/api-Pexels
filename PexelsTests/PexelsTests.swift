//
//  PexelsTests.swift
//  PexelsTests
//
//  Created by GENKI Mac on 2021/12/16.
//

import XCTest
@testable import Pexels

class PexelsTests: XCTestCase {
    
    //検索結果の個数確認テスト
    func ResultCount(){
        
        let ApiList = ApiListModel()
        let expect = expectation(description: "SendMyRequest")
        
        ApiList.searchEvents(keyword: "犬", success: {(api) in
            
            let result = api.photos.count
            print(result)
            
            //0個チェック
            XCTAssertNotEqual(result, 0)
            expect.fulfill()
            
        }, Error:{ (error) in
            
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
