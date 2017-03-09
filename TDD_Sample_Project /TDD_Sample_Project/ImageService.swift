//
//  ImageService.swift
//  TDD_Sample_Project
//
//  Created by Deepthi Bhattachar on 15/02/2017.
//  Copyright © 2017 GD. All rights reserved.
//

import UIKit

class ImageService: NSObject {
    
    var errorMessage = ""
    
    func downloadImage(url: String, completionHandler: @escaping (UIImage?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            
            let image = self.getImageFromData(data: data, error: error)
            
            completionHandler(image)
        }
        
        task.resume()
    }
    
    private func getImageFromData(data: Data?, error: Error?) -> UIImage? {
        
        guard let data = data, data.endIndex > 0, let image = UIImage(data: data) else {
            
            self.errorMessage = error?.localizedDescription ?? "Image was empty"

            return nil
        }

        return image
    }
}
