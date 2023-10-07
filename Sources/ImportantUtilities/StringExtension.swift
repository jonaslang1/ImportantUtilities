//
//  StringExtension.swift
//  
//
//  Created by Jonas Lang on 31.05.22.
//

import Foundation

public extension String {
    
    init?(htmlEncodedString: String) {
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString.string)
    }
}

public extension String {
    func detect(type: NSTextCheckingResult.CheckingType) -> [String] {
        var output: [String] = []
        let detector = try! NSDataDetector(types: type.rawValue)
        let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))

        for match in matches {
            guard let range = Range(match.range, in: self) else { continue }
            output.append(String(self[range]))
        }
        
        return output
    }
    
    func detectURLs() -> [String] {
        detect(type: .link)
    }
    
    var isURLString: Bool {
        if self.detectURLs().count > 1 {
            return false
        } else {
            return self.detectURLs().first == self
        }
    }
    
    func detectDates() -> [String] {
        detect(type: .date)
    }
    
    var isDateString: Bool {
        if self.detectDates().count > 1 {
            return false
        } else {
            return self.detectDates().first == self
        }
    }
}
