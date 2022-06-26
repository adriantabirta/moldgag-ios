//
//  RealFilenameToLocalPathMapperTests.swift
//  moldgagTests
//
//  Created by Adrian Tabirta on 26.06.2022.
//

import XCTest
@testable import moldgag

class RealFilenameToLocalPathMapperTests: XCTestCase {

    private var tested: RealFilenameToLocalPathMapper!

    override func setUp() {
        super.setUp()
        self.tested = RealFilenameToLocalPathMapper()
    }
    
    override func tearDown() {
        super.tearDown()
        self.tested = nil
    }
 
    func testMap() {
        let got = tested.map(from: "image.jpeg")
        let expected = URL(string: "file:///Users/at/Library/Developer/CoreSimulator/Devices/04D5C83F-8D27-4621-A6E9-8835A8E8396A/data/Containers/Data/Application/7771B7BD-14B8-425B-AD24-4ACC76B9ABAC/Documents/image.jpeg")
        XCTAssertEqual(got?.lastPathComponent, expected?.lastPathComponent, "Should match")
    }
}
