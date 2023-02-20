//
//  Colors.swift
//  CountryWorld
//
//  Created by Gabriele Moia on 18/02/23.
//

import Foundation
import UIKit

public protocol ColorConvertible {
    var name: String { get }
    var uiColor: UIColor { get }
}

public struct CustomColor: ColorConvertible {
    
    public var uiColor: UIColor
    public var name: String
    
    public init(name: String, code: String, alpha: CGFloat = 1.0) {
        self.name = name
        self.uiColor = ColorUtils.color(hex: code, alpha: alpha)
    }
    
    public init(name: String, red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.name = name
        self.uiColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

public class ColorUtils {
    
    public static func color(hex: String, alpha: CGFloat = 1.0) -> UIColor {
        var string: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if string.hasPrefix("#") {
            string.remove(at: string.startIndex)
        }
        
        guard string.count == 6 else {
            return UIColor.clear
        }
        
        var value: UInt64 = 0
        
        Scanner(string: string).scanHexInt64(&value)
        
        let ir = (value & 0xFF0000) >> 16
        let ig = (value & 0x00FF00) >> 8
        let ib = (value & 0x0000FF)
        
        let fr = CGFloat(ir) / 255.0
        let fg = CGFloat(ig) / 255.0
        let fb = CGFloat(ib) / 255.0
        let fa = alpha
        
        return UIColor(red: fr, green: fg, blue: fb, alpha: fa)
    }
    
    public static func hexCode(color: UIColor) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb: Int = ((Int)(r * 255) << 16) | ((Int)(g * 255) << 8) | ((Int)(b * 255) << 0)
        
        let hexCode = String(format: "#%06x", rgb)
        
        return hexCode
    }
    
}

struct Color {
    static let lightGrey: ColorConvertible = CustomColor(name: "lightGrey", code: "#f7f7f7")
    static let black: ColorConvertible = CustomColor(name: "black", code: "#00000")
    static let darkGrey: ColorConvertible = CustomColor(name: "darkGrey", code: "#000000", alpha: 0.45)
    static let themeStartGradientBackgroundColor: ColorConvertible = CustomColor(name: "themeStartGradientBackgroundColor", code: "#fe8c00")
    static let themeEndGradientBackgroundColor: ColorConvertible = CustomColor(name: "themeEndGradientBackgroundColor", code: "#f83600")
}
