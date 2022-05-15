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
}
