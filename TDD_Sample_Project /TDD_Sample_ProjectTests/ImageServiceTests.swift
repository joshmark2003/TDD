//
//  ImageServiceTests.swift
//  TDD_Sample_Project
//
//  Created by Deepthi Bhattachar on 15/02/2017.
//  Copyright © 2017 GD. All rights reserved.
//

import XCTest
import Nimble
import GCDWebServer
@testable import TDD_Sample_Project

class ImageServiceTests: XCTestCase {
    
    var service = ImageService()
    let server = GCDWebServer()
    var requestedURL = ""
    
    var downloadedImage: UIImage?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.requestedURL = ""
        
        server?.addDefaultHandler(forMethod: "GET", request: GCDWebServerRequest.self, processBlock: {request in
            
            self.requestedURL = (request?.url.absoluteString)!
            
            if self.requestedURL == "http://localhost:8080/image.png" {
                
                return GCDWebServerDataResponse(data: Fixture.getImage(imagePath: "Google"), contentType: "image/png")
            }

            return nil
        })
        server?.start()
    }
    
    override func tearDown() {
        
        server?.stop()
    }
    
    func test_WhenAnImageIsDownloaded_AnImageIsReturned() {

        let signalExpectation = expectation(description: "The URL was downloaded")
        
        service.downloadImage(url: "http://localhost:8080/image.png") {image in
            
            self.downloadedImage = image
            signalExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { _ in
            
            expect(self.downloadedImage).notTo(beNil(), description: "The downloaded image should not be nil")
            expect(self.requestedURL).to(equal("http://localhost:8080/image.png"))
        }
    }
    
    func test_WhenTheWrongImageURLIsDownloaded_NoImageIsReturned() {
        
        let signalExpectation = expectation(description: "The URL was downloaded")

        service.downloadImage(url: "http://localhost:8080/image1.png") {image in
            
            self.downloadedImage = image
            signalExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { _ in
            
            expect(self.downloadedImage).to(beNil(), description: "The downloaded image should be nil when the URL is wrong")
            expect(self.requestedURL).to(equal("http://localhost:8080/image1.png"))
            expect(self.service.errorMessage).toNot(beEmpty(), description: "There should be an error message downloading the wrong image")
        }
    }
}
