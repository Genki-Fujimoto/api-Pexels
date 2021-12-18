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
        
        let mvcButton = app.navigationBars["Pexels.View"].buttons["MVC-Rxswift"]
        mvcButton.tap()
        
        app.searchFields["画像検索"].tap()
        app.searchFields["画像検索"].buttons["Clear text"].tap()
        app.buttons["Search"].tap()
    
        app.alerts["注意"].scrollViews.otherElements.buttons["OK"].tap()
        app.tap()
        
        app.searchFields["画像検索"].tap()
        app.searchFields["画像検索"].typeText(":")
        XCUIApplication().searchFields["画像検索"].tap()
        app.buttons["Search"].tap()
        
        app.alerts["確認"].scrollViews.otherElements.buttons["OK"].tap()
        
    }
}
