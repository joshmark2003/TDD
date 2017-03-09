//
//  CustomerServiceTest.swift
//  TDD_Sample_Project
//
//  Created by Deepthi Bhattachar on 17/02/2017.
//  Copyright © 2017 GD. All rights reserved.
//

import XCTest
import Nimble
import GCDWebServer

@testable import TDD_Sample_Project

class CustomerServiceTest: XCTestCase {
    
    var service = CustomerService()
    let server = GCDWebServer()
    var requestedURL = ""
    
    var customer: Customer?
    var parsingError: NSError?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        service.baseURL = "http://localhost:8080/customer/"
        self.requestedURL = ""
        
        server?.addDefaultHandler(forMethod: "GET", request: GCDWebServerRequest.self, processBlock: {request in
            
            self.requestedURL = (request?.url.absoluteString)!
            
            if self.requestedURL == "http://localhost:8080/customer/123" {
                return GCDWebServerDataResponse(data: (Fixture.getJSON(jsonPath: "CustomerResponse"))?.data(using: String.Encoding.utf8), contentType: "json")
            }
            
            return nil
        })
        server?.start()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        server?.stop()
    }
    
    func test_WhenCustomerDataIsRequested_ReturnCustomer() {
        
        let signalExpectation = expectation(description: "The URL was downloaded")
        
        service.getCustomer(customerId: "123"){ customer, error in
            self.customer = customer
            self.parsingError = error
            signalExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { _ in
            
            expect(self.parsingError).to(beNil(), description: "Error is nil when we get customer data")
            expect(self.customer).notTo(beNil(), description: "Customer data should not be nil")
            expect(self.customer?.customerID).to(equal("123"), description: "The customerID should be 123")
            expect(self.customer?.firstName).to(equal("John"), description: "The customerFirstName should be John")
            expect(self.customer?.lastName).to(equal("Smith"), description: "The customerLastName should be Smith")
        }
    }
    
    func test_WhenWrongCustomerIDIsRequested_ReturnError() {
        
        let signalExpectation = expectation(description: "The URL was downloaded")
        
        service.getCustomer(customerId: "234"){ customer, error in
            self.parsingError = error
            signalExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { _ in
            
            expect(self.parsingError).notTo(beNil(), description: "Error is not nil when we try to get customer data for wrong Customer ID")
        }
    }
}
