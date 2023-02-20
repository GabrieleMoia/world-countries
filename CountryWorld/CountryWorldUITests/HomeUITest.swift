//
//  HomeUITest.swift
//  CountryWorldUITests
//
//  Created by Gabriele Moia on 17/02/23.
//

import XCTest

final class HomeUITest: XCTestCase {

    override class func setUp() {
        super.setUp()
        XCUIApplication().launch()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFilterByLanguage() throws {
        // Recorded by Xcode
        
        let searchTextField = XCUIApplication().searchFields.element
        
        searchTextField.tap()

        // Check if there's value
        let button = XCUIApplication().searchFields.element.buttons.element
        if button.exists {
            
            button.tap()
        }

        searchTextField.typeText("german")
        
        let tableView = XCUIApplication().tables.element
        
        XCTAssert(tableView.children(matching: .cell).count == 7, "TableView must contains 7 cells")
    }
    
    func testFilterByName() throws {
        // Clear button
        
        let searchTextField = XCUIApplication().searchFields.element
        searchTextField.tap()
        
        // Check if there's value
        let button = XCUIApplication().searchFields.element.buttons.element
        
        if button.exists {
            
            button.tap()
        }

        searchTextField.typeText("italy")

        let tableView = XCUIApplication().tables.element
        
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", "Italy")

        XCTAssert(tableView.children(matching: .cell).staticTexts.containing(predicate).count > 0, "Search must filter by name")
    }
    
    func testFilterByRegion() throws {
        // Clear button
        
        let searchTextField = XCUIApplication().searchFields.element
        
        searchTextField.tap()
        
        // Check if there's value
        let button = XCUIApplication().searchFields.element.buttons.element
        
        if button.exists {
            
            button.tap()
        }
        
        searchTextField.typeText("europe")
        
        let tableView = XCUIApplication().tables.element
        
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", "europe")
        
        let numberOfCell = tableView.children(matching: .cell).count
        let numberOfLabelWithEurope = tableView.children(matching: .cell).staticTexts.containing(predicate).count
        
        XCTAssertTrue(numberOfCell == numberOfLabelWithEurope)
    }
}
