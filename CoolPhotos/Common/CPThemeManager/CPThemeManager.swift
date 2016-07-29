//
//  CPThemeManager.swift
//  CoolPhotos
//
//  Created by 邓永豪 on 16/7/29.
//  Copyright © 2016年 DYH. All rights reserved.
//

import UIKit

enum CPThemeType: Int {
    case CPThemeType_BT_BLUE = 1
    case CPThemeType_BT_BLACK = 2
    case CPThemeType_ONLINE = 3
}

protocol CPThemeListenerProtocol {
    func CPThemeDidNeedUpdateStyle() -> Void
}

class CPThemeManager: NSObject {
    
    var themeStyle: CPThemeType?
    var themeBundle: NSBundle?
    var themeColors: Dictionary<String,String>?
    
    // MARK: 单例
    static let shareInstance = CPThemeManager()
    private override init() {
        
    }
    
    // MARK: 设置皮肤
    func setThemeStyle(themeStyle: CPThemeType) {
        if self.themeStyle == themeStyle {
            return;
        }
        self.themeStyle = themeStyle;
        NSUserDefaults.standardUserDefaults().setValue(themeStyle.rawValue, forKey: "kCPThemeStyle")
        
        var bundleName: String = String()
        if themeStyle == .CPThemeType_BT_BLACK {
            bundleName = "blackTheme"
        } else if themeStyle == .CPThemeType_BT_BLUE {
            bundleName = "blueTheme"
        }
        if bundleName.characters.count <= 0 {
            return
        }
        
        let themeBundlePath = NSBundle.pathForResource(bundleName, ofType: "bundle", inDirectory: NSBundle.mainBundle().bundlePath)
        self.themeBundle = NSBundle.init(path: themeBundlePath!)
        
        let path = self.themeBundle?.pathForResource("ThemeColor", ofType: "txt")
        
        let data: NSData = NSData.init(contentsOfFile: path!)!
        
        do {
            self.themeColors = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? Dictionary<String, String>
        } catch let error as NSError {
            print(error)
        }
        NSNotificationCenter.defaultCenter().postNotificationName("BTThemeChangeNotification", object: nil)
    }

    func addThemeListener(object: AnyObject) {
        
    }
    
    func removeThemeListener(object: AnyObject) {
        NSNotificationCenter.defaultCenter().removeObserver(object)
    }

}
