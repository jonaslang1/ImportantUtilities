import XCTest
@testable import ImportantUtilities

final class ImportantUtilitiesTests: XCTestCase {
    func testFormatDate() {
        let date = Date()
        let format = "dd.MM.yyyy"
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let formatted = formatter.string(from: date)
        
        XCTAssertEqual(formatted, date.formatted(format))
    }
    
    func testPlatformName() {
        XCTAssertEqual(UIDevice.platformName, "iOS")
    }
    
    func testDeviceName() {
        XCTAssertTrue(UIDevice.modelName.contains("Simulator"))
    }
    
    func testDetectURLs() {
        let input = "This is a test with the URL https://www.test.com to be detected. www.test.com, aaiuggd http://test.com"
        XCTAssertEqual(detectURLs(string: input), ["https://www.test.com", "www.test.com", "http://test.com"])
    }
}
