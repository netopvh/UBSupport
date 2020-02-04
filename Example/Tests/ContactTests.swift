//
//  ContactTests.swift
//  UBSupport_Tests
//
//  Created by Usemobile on 09/10/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest

@testable import UBSupport_Example
@testable import UBSupport

class ContactTests: XCTestCase {
    
    
    var contactViewController: ContactViewController?
    let subjects = ["Dúvida", "Sugestão", "Financeiro", "Reclamação", "Segurança"]

    override func setUp() {
        let model = SupportModel(email: "test@test.com", phone: "1234567890", subjects: self.subjects)
        let settings = SupportSettings.default
        self.contactViewController = ContactViewController(model: model, settings: settings)
    }

    override func tearDown() {
        self.contactViewController = nil
    }
    
    func testSubjects() {
        guard let subjectView = self.contactViewController?.contactView.subjectView else {
            XCTFail("SUBJECT VIEW NIL")
            return
        }
        
        self.subjects.forEach({
            XCTAssertTrue(subjectView.subjects.contains($0)) 
        })
        
        
    }
    
    func testContactMessage() {
        guard let contactView = self.contactViewController?.contactView else {
            XCTFail("CONTACT VIEW NIL")
            return
        }
        
        XCTAssert(contactView.lblTitle.text != nil && contactView.lblTitle.text != "")
        let settings = contactView.settings
        settings.emptySupportText = true
        
        contactView.settings = settings
        XCTAssert(contactView.lblTitle.text == nil || contactView.lblTitle.text == "")
        
        
    }
    
    
}
