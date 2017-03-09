//
//  ViewControllerTest.swift
//  TDD_Sample_Project
//
//  Created by Deepthi Bhattachar on 16/02/2017.
//  Copyright © 2017 GD. All rights reserved.
//

import XCTest
import Nimble

@testable import TDD_Sample_Project

class StartViewControllerTest: XCTestCase {
    
    var viewController: StartViewController?
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_whenTheVie3wControllerIsDisplayed_TheImageIsDownloadedAndDisplayed() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        viewController = storyboard.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController
        
        let fakeImageService = FakeImageService()
        viewController?.imageService = fakeImageService
        
        viewController?.beginAppearanceTransition(true, animated: false)
        viewController?.endAppearanceTransition()
        
        Nimble.AsyncDefaults.Timeout = 5.0
        
        expect(fakeImageService.imageURL).toEventuallyNot(beEmpty(), description: "When the viewController is displayed, the image should be displayed")
        
        expect(self.viewController?.imgProduct.image).toNot(beNil())
        
        let image = viewController?.imgProduct.image
                
        expect(image?.cgImage?.bitmapInfo).to(equal(UIImage(data: Fixture.getImage(imagePath: "Google"))?.cgImage?.bitmapInfo))
    }
    
    func test_WhenButtonActionIsCalled_SetLabelTextToCustomerFirstName() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        viewController = storyboard.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController
        
        let fakeCustomerService = FakeCustomerService()
        viewController?.customerService = fakeCustomerService
        
        viewController?.beginAppearanceTransition(true, animated: false)
        viewController?.endAppearanceTransition()

        viewController?.buttonPressedAction()
        
        Nimble.AsyncDefaults.Timeout = 5.0
                
        expect(self.viewController?.lblName?.text).toEventually(equal("John"), description: "When viewController is displayed, the name should be displayed in the label")
    }
}
