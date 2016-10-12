//
//  CPThemeManager.swift
//  CoolPhotos
//
//  Created by 邓永豪 on 16/7/29.
//  Copyright © 2016年 DYH. All rights reserved.
//

import UIKit

enum CPThemeType {
    case CPThemeType_BT_BLUE
    case CPThemeType_BT_BLACK
    case CPThemeType_ONLINE
}

protocol CPThemeListenerProtocol {
    func CPThemeDidNeedUpdateStyle() -> Void
}

class CPThemeManager: NSObject {
    
    private var themeStyle: CPThemeType?
    private var themeBundle: Bundle?
    private var themeColors: Dictionary<String, AnyObject>?

    // MARK: 单例
    static let shareInstance = CPThemeManager()
    private override init() {}
    
    // MARK: 设置皮肤
    func setThemeStyle(themeStyle: CPThemeType) {
        if self.themeStyle == themeStyle {
            return;
        }
        self.themeStyle = themeStyle;
        UserDefaults.standard.setValue(themeStyle.hashValue, forKey: "kCPThemeStyle")
        
        var bundleName: String = String()
        if themeStyle == .CPThemeType_BT_BLACK {
            bundleName = "blackTheme"
        } else if themeStyle == .CPThemeType_BT_BLUE {
            bundleName = "blueTheme"
        }
        if bundleName.characters.count <= 0 {
            return
        }
        
        let themeBundlePath = Bundle.path(forResource: bundleName, ofType: "bundle", inDirectory: Bundle.main.bundlePath)
        self.themeBundle = Bundle.init(path: themeBundlePath!)
        
        let path = self.themeBundle?.path(forResource: "ThemeColor", ofType: "txt")
        
        let data: NSData = NSData.init(contentsOfFile: path!)!
        
        do {
            self.themeColors = try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) as? Dictionary<String, String> as Dictionary<String, AnyObject>?
        } catch let error as NSError {
            print(error)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CPThemeChangeNotification"), object: nil)
    }

    func addThemeListener(object: CPBaseViewController) {
        NotificationCenter.default.addObserver(object,
                                                         selector:#selector(object.CPThemeDidNeedUpdateStyle),
                                                         name: NSNotification.Name(rawValue: "CPThemeChangeNotification"),
                                                         object: nil)
    }
    
    func removeThemeListener(object: AnyObject) {
        NotificationCenter.default.removeObserver(object)
    }
    
    func CPThemeImage(imageName: String, completionHandler: @escaping (_ image: UIImage) -> Void) {
        DispatchQueue.global().async {
            let imagePath = "image/" + imageName
            var image: UIImage?
            image = UIImage.loadImage(imageName: imagePath, fromBundle: self.themeBundle!)
            
            if image == nil && self.themeStyle == .CPThemeType_BT_BLACK {
                let themeBundlePath = Bundle.path(forResource: "blueTheme", ofType: "bundle", inDirectory: Bundle.main.bundlePath)
                self.themeBundle = Bundle.init(path: themeBundlePath!)
                image = UIImage.loadImage(imageName: imagePath, fromBundle: self.themeBundle!)
            }
            if image == nil {
                image = UIImage.init(named: imageName)
            }
            DispatchQueue.main.sync {
               completionHandler(image!)
            }
        }
    }
    
    func CPThemeColor(colorKey: String) -> UIColor {
        let jsonValue = themeColors?.stringValueForKey(key: colorKey, defaultValue: "0xffffffff",
                                                            operation: .NSStringOperationTypeNone)
        if jsonValue == nil {
            return UIColor.black
        }
        let colorValue = strtoul(jsonValue!, nil, 16)
        return UIColor.colorAWithHex(hex: colorValue)
    }

}
