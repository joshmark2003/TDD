//
//  FakeImageService.swift
//  TDD_Sample_Project
//
//  Created by Deepthi Bhattachar on 16/02/2017.
//  Copyright © 2017 GD. All rights reserved.
//

import UIKit
@testable import TDD_Sample_Project

class FakeImageService: ImageService {

    var imageURL = ""
    
    override func downloadImage(url: String, completionHandler: @escaping (UIImage?) -> Void) {
        
        imageURL = url
        
        completionHandler(UIImage(data: Fixture.getImage(imagePath: "Google")))
    }
}
