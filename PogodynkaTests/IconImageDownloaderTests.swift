//
//  IconImageDownloaderTests.swift
//  PogodynkaTests
//
//  Created by Rafal Korzynski on 08/03/2024.
//

import XCTest
import Nimble
@testable import Pogodynka

final class IconImageDownloaderTests: XCTestCase {
    
    var sut: IconImageDownloader!
    var downloadDataTaskMock: DownloadDataTaskMock!
    var dummyIconName: String!

    override func setUp() {
        super.setUp()
        dummyIconName = "01n"
        downloadDataTaskMock = DownloadDataTaskMock()
        sut = IconImageDownloader(downloadDataTask: downloadDataTaskMock)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        dummyIconName = nil
        downloadDataTaskMock = nil
    }
    
    // MARK: - TESTS -
    
    func test_downloadImageFails_returnsNil() {
        var returnedImage: UIImage? = UIImage()
        var comletionCalled = false
        
        sut.download(iconName: dummyIconName) { image in
            comletionCalled = true
            returnedImage = image
        }
        
        expect(comletionCalled).to(beTrue())
        expect(self.downloadDataTaskMock.runCalled).to(beTrue())
        expect(self.sut.imageURL).toNot(beNil())
        expect(returnedImage).to(beNil())
    }
    
    func test_downloadImageSuccess_returnsImage() {
        var returnedImage: UIImage? = UIImage()
        var comletionCalled = false
        downloadDataTaskMock.returnedImage = UIImage(systemName: "star")
        
        sut.download(iconName: dummyIconName) { image in
            comletionCalled = true
            returnedImage = image
        }
        
        expect(comletionCalled).to(beTrue())
        expect(self.downloadDataTaskMock.runCalled).to(beTrue())
        expect(self.sut.imageURL).toNot(beNil())
        expect(returnedImage).toNot(beNil())
    }
}

class DownloadDataTaskMock: DownloadDataTaskProtocol {
    var runCalled = false
    var returnedImage: UIImage? = nil
    
    func run(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        runCalled = true
        completion(returnedImage?.pngData(), nil, nil)
    }
}
