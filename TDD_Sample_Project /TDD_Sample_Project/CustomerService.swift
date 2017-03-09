//
//  CustomerService.swift
//  TDD_Sample_Project
//
//  Created by Deepthi Bhattachar on 17/02/2017.
//  Copyright © 2017 GD. All rights reserved.
//

import UIKit

class CustomerService: NSObject {

    var baseURL = "http://realapi/customer/"
    
    var customerDetails = Customer()
    
    func getCustomer(customerId: String, completionHandler: @escaping (Customer?, NSError?) -> Void) {
        
        let url = URL(string: "\(baseURL)\(customerId)")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard
                let data = data,
                let str = String(data: data, encoding: .utf8),
                let error = self.customerDetails.fromJSON(json: str) else {

                let customerDataToReturn = Customer()
                
                customerDataToReturn.customerID = self.customerDetails.customerID
                customerDataToReturn.firstName = self.customerDetails.firstName
                customerDataToReturn.lastName = self.customerDetails.lastName
                
                completionHandler(customerDataToReturn, nil)
                
                return
            }
            completionHandler(nil, error)
        }
        
        task.resume()
    }
}
