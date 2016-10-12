//
//  CPStyle.swift
//  CoolPhotos
//
//  Created by 邓永豪 on 16/8/1.
//  Copyright © 2016年 DYH. All rights reserved.
//

import UIKit

class CPStyle: NSObject {

}

extension UIImage {
    static func loadImage(imageName: String, fromBundle: Bundle) -> UIImage {
        var image = UIImage()
        var isImageUnder3x = false
        if imageName.characters.count > 0 {
            var nameAndType = imageName.components(separatedBy: ".")
            var name: String!
            name = nameAndType.first
            let type = nameAndType.count > 1 ? nameAndType[1] : "png"
            var imagePath: String?
            imagePath  =  fromBundle.path(forResource: name, ofType: type)
            let nameLength = name.characters.count
            if imagePath == nil && (name?.hasSuffix("@2x"))! && nameLength > 3 {
                let index = name.index(name.endIndex, offsetBy: -3)
                name = name.substring(with: Range<String.Index>(name.startIndex ..< index))
            }
            if imagePath == nil && !name.hasSuffix("@2x") {
                let name2x = name + "@2x";
                imagePath = fromBundle.path(forResource: name2x, ofType: type)
                if imagePath == nil && !name.hasSuffix("3x") {
                    let name3x = name + "@3x"
                    imagePath = fromBundle.path(forResource: name3x, ofType: type)
                    isImageUnder3x = true
                }
            }
            if imagePath != nil {
                image = UIImage.init(contentsOfFile: imagePath!)!
            }
        }
        if #available(iOS 8, *) {
            return image
        }
        if !isImageUnder3x {
            return image
        }
        return image.scaledImageFrom3x()
    }
    
    private func scaledImageFrom3x() -> UIImage {
        let locScale = UIScreen.main.scale
        let theRate: CGFloat = 1.0 / 3.0
        let oldSize = self.size
        let scaleWidth = CGFloat(oldSize.width) * theRate
        let scaleHeight = CGFloat(oldSize.height) * theRate
        var scaleRect = CGRect.zero
        scaleRect.size.width = scaleWidth
        scaleRect.size.height = scaleHeight
        UIGraphicsBeginImageContextWithOptions(scaleRect.size, false, locScale)
        draw(in: scaleRect)
        var newImage = UIImage()
        newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension UIColor {
    static func colorAWithHex(hex:UInt) -> UIColor {
        var red, green, blue, alpha : Int
        blue = Int(hex) & 0x000000FF
        green = ((Int(hex) & 0x0000FF00) >> 8)
        red = ((Int(hex) & 0x00FF0000) >> 16)
        alpha = ((Int(hex) & 0xFF000000) >> 24)
        return UIColor.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
    }

}
