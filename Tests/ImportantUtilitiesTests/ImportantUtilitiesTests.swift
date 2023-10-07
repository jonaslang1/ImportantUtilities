import XCTest
@testable import ImportantUtilities

final class ImportantUtilitiesTests: XCTestCase {
    
    func testFormatDate() {
        let date = Date()
        let format = "dd.MM.yyyy"
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
		formatter.locale = Locale(identifier: "de_DE")
		formatter.timeZone = TimeZone(identifier: "UTC+1")
        let formatted = formatter.string(from: date)
        
		XCTAssertEqual(formatted, date.formatted(format))
    }
    
    func testPlatform() {
        XCTAssertEqual(UIDevice.platform, UIDevice.Platform.iOS)
    }
    
    func testDeviceName() {
        XCTAssertTrue(UIDevice.modelName.contains("Simulator"))
    }
    
    func testURLDetection() {
        let input = "This is a test with the URL https://www.test.com to be detected. www.test.com, aaiuggd http://test.com"
        XCTAssertEqual(input.detectURLs(), ["https://www.test.com", "www.test.com", "http://test.com"])
        
        let stringsTrue = ["https://www.test.com", "www.test.com", "http://test.com"]
        for string in stringsTrue {
            XCTAssertTrue(string.isURLString)
        }
        let stringsFalse = ["wwwte.a", "ww.testcom", "http:/testcom"]
        for string in stringsFalse {
            XCTAssertFalse(string.isURLString)
        }
    }
    
    func testDateDetection() {
        let input = "This is a test with the Date 25.05.2022 to be detected. 1.3.1920, aaiuggd 19.11.12"
        XCTAssertEqual(input.detectDates(), ["25.05.2022", "1.3.1920", "19.11.12"])
        
        let stringsTrue = ["25.05.2022", "1.3.1920", "19.11.12", "23-02-2003"]
        for string in stringsTrue {
            XCTAssertTrue(string.isDateString)
        }
        let stringsFalse = ["12.05.", "20.3.19233", "19.11.1", "24.24.2424"]
        for string in stringsFalse {
            XCTAssertFalse(string.isDateString)
        }
    }
    
    func testHtmlEncodedStringInit() {
        let input = "&#8220; &#160; &#160; [&#8230;]"
        XCTAssertEqual(String(htmlEncodedString: input), "“     […]")
    }
}
