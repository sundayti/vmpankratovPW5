//
//  PresenterTestLaunchTests.swift
//  PresenterTest
//
//  Created by Tom Tim on 18.12.2024.
//

import XCTest

final class PresenterTestLaunchTests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch() 
    }
    
    func testNewsListAndDetailOpening() {
        let table = app.tables.element(boundBy: 0)
        XCTAssertTrue(table.waitForExistence(timeout: 10), "The news table did not appear")
        
        let firstCell = table.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 10), "There are no news items to display")
        
        firstCell.tap()
        
        let webView = app.webViews.element(boundBy: 0)
        XCTAssertTrue(webView.waitForExistence(timeout: 10), "WebView не появился после выбора новости")
    }
}
