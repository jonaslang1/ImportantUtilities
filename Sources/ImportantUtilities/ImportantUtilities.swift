//
//  ImportantUtilities.swift
//  
//
//  Created by Jonas Lang on 02.05.22.
//

import Foundation
import SwiftUI

public extension View {
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(action))
    }
}

struct ViewDidLoadModifier: ViewModifier {
    @State private var didLoad = false
    private let action: (() -> ())?
    
    init(_ action: (() -> ())? = nil) {
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }
}

#if !os(watchOS)
public class Orientation: ObservableObject {
    @Published var isLandscape: Bool = UIDevice.current.orientation.isLandscape
    @Published var isPortait: Bool = UIDevice.current.orientation.isPortrait
}
#endif

public extension UIImage {
    func withColor(_ color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        // 1
        let drawRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        // 2
        color.setFill()
        UIRectFill(drawRect)
        // 3
        draw(in: drawRect, blendMode: .destinationIn, alpha: 1)
        
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
}

public extension Date {
    @available(iOS, deprecated: 15.0, message: "Use formatted( _ format: FormatStyle) instead.")
    func formatted(_ format: String) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "de_DE")
        df.timeZone = TimeZone(identifier: "UTC+1")
        df.dateFormat = format
        return df.string(from: self)
    }
    
    @available(iOS 15.0, *)
	@available(watchOS 8.0, *)
    static let defaultDateStyle = Date.FormatStyle().day().month(.defaultDigits).year()
    @available(iOS 15.0, *)
	@available(watchOS 8.0, *)
    static let defaultTimeStyle = Date.FormatStyle().minute().hour()
}

#if !os(watchOS)
public extension Color {
    static let lightText = Color(UIColor.lightText)
    static let darkText = Color(UIColor.darkText)
    
    static let label = Color(UIColor.label)
    static let secondaryLabel = Color(UIColor.secondaryLabel)
    static let tertiaryLabel = Color(UIColor.tertiaryLabel)
    static let quaternaryLabel = Color(UIColor.quaternaryLabel)
    
    static let systemBackground = Color(UIColor.systemBackground)
    static let secondarySystemBackground = Color(UIColor.secondarySystemBackground)
    static let tertiarySystemBackground = Color(UIColor.tertiarySystemBackground)
}

public func openURL(url: String) {
    var u: URL
    if url.contains("http") || url.contains("mailto"){
        u = URL(string: url)!
    } else {
        u = URL(string: "https://\(url)")!
    }
    UIApplication.shared.open(u)
}
#endif
