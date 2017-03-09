//
//  CustomerTest.swift
//  TDD_Sample_Project
//
//  Created by Deepthi Bhattachar on 17/02/2017.
//  Copyright © 2017 GD. All rights reserved.
//

import XCTest
import Nimble

@testable import TDD_Sample_Project

class CustomerTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_WhenParsingValidJson_ReturnNoError() {
        
        let customer = Customer()
        let jsonString = Fixture.getJSON(jsonPath: "CustomerResponse")
        
        expect(jsonString).notTo(beNil(), description: "Json string should not be nil")
        
        let error = customer.fromJSON(json: jsonString!)
        
        expect(error).to(beNil(), description: "Error should be nil")
        expect(customer.customerID).to(equal("123"), description: "The customerID should be 123")
        expect(customer.firstName).to(equal("John"), description: "The customerFirstName should be John")
        expect(customer.lastName).to(equal("Smith"), description: "The customerLastName should be Smith")
    }
    
    func test_WhenParsingInvalidJSON_ReturnError() {
        
        let customer = Customer()
        let jsonString = Fixture.getJSON(jsonPath: "InvalidJSON")

        expect(jsonString).notTo(beNil(), description: "Json string should not be nil")
        
        let error = customer.fromJSON(json: jsonString!)
        
        expect(error).notTo(beNil(), description: "Error should not be nil")
        expect(error?.code).to(equal(-2), description:"Invalid json")
        expect(error?.localizedDescription).to(equal("Invalid JSON"), description:"Invalid json")
    }
}
