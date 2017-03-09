//
//  Customer.swift
//  TDD_Sample_Project
//
//  Created by Deepthi Bhattachar on 17/02/2017.
//  Copyright © 2017 GD. All rights reserved.
//

import UIKit

class Customer: NSObject {

    var customerID: String?
    var firstName: String?
    var lastName: String?
    
    func fromJSON(json: String) -> NSError? {
        
        guard let data = json.data(using: String.Encoding.utf8) else {
            
            return NSError(domain: "TDD_Sample", code: -1, userInfo: [NSLocalizedDescriptionKey:"Invalid string data"])
        }
        
        if let jsonResult = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
        
            self.customerID = jsonResult?["id"] as? String
            self.firstName = jsonResult?["first_name"] as? String
            self.lastName = jsonResult?["last_name"] as? String
            
            return nil
        }
        
        return NSError(domain: "TDD_Sample", code: -2, userInfo: [NSLocalizedDescriptionKey:"Invalid JSON"])
    }
}
