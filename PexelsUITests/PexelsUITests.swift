//
//  PexelsUITests.swift
//  PexelsUITests
//
//  Created by GENKI Mac on 2021/12/16.
//

import XCTest

class PexelsUITests: XCTestCase {

    //UI動作コード
    func test(){
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.searchFields["画像検索"].tap()
        app.searchFields["画像検索"].typeText("猫")
        XCUIApplication().searchFields["画像検索"].tap()
        app.buttons["Search"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.children(matching: .cell).element(boundBy: 1).swipeUp()
        
        let staticText = tablesQuery.children(matching: .cell).element(boundBy: 5)
        staticText.tap()
        
        let mvcButton = app.navigationBars["Pexels.View"].buttons["MVC"]
        mvcButton.tap()
        
        
    }
}
