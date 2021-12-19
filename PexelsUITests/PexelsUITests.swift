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
        
        let searchField = app.searchFields["画像検索"]
        let tablesQuery = app.tables
        let staticText = tablesQuery.children(matching: .cell)
        let mvcButton = app.navigationBars["Pexels.View"].buttons["MVVC-Rxswift"]
        
        searchField.tap()
        searchField.typeText("猫")
        
        tablesQuery.children(matching: .cell).element(boundBy: 1).swipeUp()
        staticText.element(boundBy: 5).tap()
        
        mvcButton.tap()
        searchField.buttons["Clear text"].tap()
        
        searchField.tap()
        searchField.typeText("犬")
        staticText.element(boundBy: 4).tap()
        
    }
}
