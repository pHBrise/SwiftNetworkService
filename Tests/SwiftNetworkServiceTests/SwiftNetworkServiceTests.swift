import XCTest
@testable import SwiftNetworkService

final class SwiftNetworkServiceTests: XCTestCase {
    let data = """
    {
        "money": "1000"
    }
    """.data(using: .utf8)!
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftNetworkService().text, "Hello, World!")
    }
    
    func testMackDataLoader() {
        let expectation = self.expectation(description: "\(#file), \(#function): WaitForDecodingMockData")
        //using the data constant we just created
            let mockDataLoader = MockDataLoader(
                data: data,
                response: nil,
                error: nil
            )
        let request = URLRequest(url: URL(string: "www.google.com")!)
            mockDataLoader.loadData(using: request) { (data, nil, error) in
                XCTAssertNotNil(mockDataLoader.data)
                XCTAssertNil(mockDataLoader.response)
                XCTAssertNil(mockDataLoader.error)
                let decoder = JSONDecoder()
                let dictionary = try? decoder.decode([String:String].self, from:       mockDataLoader.data!)
                let money = dictionary?["money"]
                XCTAssertNotNil(String(money!))
                expectation.fulfill()
            }
        wait(for: [expectation], timeout: 1.0)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
