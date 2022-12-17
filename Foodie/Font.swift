//
//  Font.swift
//  Foodie
//
//  Created by Aaqib Seliya on 13/12/2022.
//

import Foundation
import UIKit

protocol Font {
    func of(size: CGFloat) -> UIFont?
    func of(textStyle: UIFont.TextStyle, defaultSize: CGFloat, maxSize: CGFloat?) -> UIFont?
}

extension Font where Self: RawRepresentable, Self.RawValue == String {
    func of(size: CGFloat) -> UIFont? {
        return UIFont(name: rawValue, size: size)
    }
    
    func of(textStyle: UIFont.TextStyle, defaultSize: CGFloat, maxSize: CGFloat? = nil) -> UIFont? {
        guard let font = of(size: defaultSize) else { return nil }
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        
        if let maxSize = maxSize {
            return fontMetrics.scaledFont(for: font, maximumPointSize: maxSize)
        } else {
            return fontMetrics.scaledFont(for: font)
        }
    }
}

enum BrandonGrotesque: String, Font {
    case black = "BrandonGrotesque-Black"
    case bold = "BrandonGrotesque-Bold"
    case italic = "BrandonGrotesque-RegularItalic"
    case boldItalic = "BrandonGrotesque-BoldItalic"
    case medium = "BrandonGrotesque-Medium"
    case mediumItalic = "BrandonGrotesque-MediumItalic"
}
