//
//  ViewController.swift
//  TDD_Sample_Project
//
//  Created by Deepthi Bhattachar on 15/02/2017.
//  Copyright © 2017 GD. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    var imageService = ImageService()
    
    var customerService = CustomerService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        imageService.downloadImage(url: "https://www.asone.co.uk/wp-content/uploads/2015/11/google-logo.jpg") { (image) in
            DispatchQueue.main.async {
                self.imgProduct.image = image
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressedAction() {
                
        customerService.getCustomer(customerId: "123") { (customer, error) in
           
            DispatchQueue.main.async {
                self.lblName.text = customer?.firstName
            }
        }
    }
}
