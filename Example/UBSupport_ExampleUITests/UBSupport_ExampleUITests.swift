//
//  UBSupport_ExampleUITests.swift
//  UBSupport_ExampleUITests
//
//  Created by Usemobile on 09/10/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest

class UBSupport_ExampleUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {

        self.app = XCUIApplication()
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        self.app = nil
    }

    func testFlow() {
        self.app.launch()
        
        self.app.staticTexts["Enviar Mensagem"].tap()
        self.app.otherElements["Assunto"].tap()
    }

//    func testLaunchPerformance() {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
