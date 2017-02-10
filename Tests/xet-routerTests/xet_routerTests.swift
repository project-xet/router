import XCTest
@testable import xet_router

class xet_routerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(xet_router().text, "Hello, World!")
    }


    static var allTests : [(String, (xet_routerTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
