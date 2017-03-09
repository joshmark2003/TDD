//
//  FakeCustomerService.swift
//  TDD_Sample_Project
//
//  Created by Deepthi Bhattachar on 17/02/2017.
//  Copyright © 2017 GD. All rights reserved.
//

import UIKit
@testable import TDD_Sample_Project

class FakeCustomerService: CustomerService {
    
    override func getCustomer(customerId: String, completionHandler: @escaping (Customer?, NSError?) -> Void) {
        
        let customerData = Customer()
        customerData.customerID = "123"
        customerData.firstName = "John"
        customerData.lastName = "Smith"
        
        completionHandler(customerData, nil)
    }
}
