//
//  Fixture.swift
//  TDD_Sample_Project
//
//  Created by Deepthi Bhattachar on 15/02/2017.
//  Copyright © 2017 GD. All rights reserved.
//

import UIKit

class Fixture: NSObject {

    static func getImage(imagePath: String) -> Data {
        
        guard let path = Bundle(for: Fixture.self).path(forResource: imagePath, ofType: "png"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                NSLog("************* No Fixture Image found with name '\(imagePath).png', did you add it to the fixtures? *************")
                return Data()
        }
        
        return data
    }
    
    static func getJSON(jsonPath: String) -> String? {
        
        guard let path = Bundle(for: Fixture.self).path(forResource: jsonPath, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                NSLog("************* No Fixture JSON found with name '\(jsonPath).json', did you add it to the fixtures? *************")
                return nil
        }
        
        let jsonString = String(data: data, encoding: String.Encoding.utf8)
        
        return jsonString
    }
}
