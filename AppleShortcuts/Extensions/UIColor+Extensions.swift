//
//  Extensions.swift
//  AppleShortcuts
//
//  Created by Hassan El Desouky on 8/8/19.
//  Copyright © 2019 Hassan El Desouky. All rights reserved.
//

import UIKit

public extension UIColor {
  
  convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
    self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
  }
  
  static var customBackgroundColor: UIColor = {
    return UIColor(r: 239, g: 239, b: 244)
  }()
  
}

extension UIColor {
  convenience init(hexString: String, alpha: CGFloat = 1) {
    assert(hexString[hexString.startIndex] == "#", "Expected hex string of format #RRGGBB")
    
    let scanner = Scanner(string: hexString)
    scanner.scanLocation = 1  // skip #
    
    var rgb: UInt32 = 0
    scanner.scanHexInt32(&rgb)
    
    self.init(
      red:   CGFloat((rgb & 0xFF0000) >> 16)/255.0,
      green: CGFloat((rgb &   0xFF00) >>  8)/255.0,
      blue:  CGFloat((rgb &     0xFF)      )/255.0,
      alpha: alpha)
  }
}

extension UIColor {
  func toHexString() -> String {
    var r:CGFloat = 0
    var g:CGFloat = 0
    var b:CGFloat = 0
    var a:CGFloat = 0
    
    getRed(&r, green: &g, blue: &b, alpha: &a)
    
    let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
    
    return String(format:"#%06x", rgb)
  }
}

extension UIColor {
  class func color(data:Data) -> UIColor? {
    return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
  }
  
  func encode() -> Data? {
    return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
  }
}

extension UIColor {
  static func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
      cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
      return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
}
