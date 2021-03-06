//
//  CPObjectExtension.swift
//  CoolPhotos
//
//  Created by 邓永豪 on 16/8/1.
//  Copyright © 2016年 DYH. All rights reserved.
//

import UIKit

enum CPStringOperationType {
    case NSStringOperationTypeNone                  // 无需额外操作
    case NSStringOperationTypeTrim                  // 去空
    case NSStringOperationTypeDecodeUnicode         // 解汉字
}

class CPObjectExtension: NSObject {

}

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    func decodeUnicode() -> String {
        let str1 = self.replacingOccurrences(of: "\\u", with: "\\u")
        let str2 = str1.replacingOccurrences(of: "\"", with: "\\\"")
        let str3 = "\"" + str2 + "\""
        var str4: String?
        do {
            str4 = try PropertyListSerialization.propertyList(from: str3.data(using: String.Encoding.utf8)!,
                                                                        options: PropertyListSerialization.MutabilityOptions.mutableContainersAndLeaves,
                                                                        format: nil) as? String
        } catch {
        
        }
        
        return str4!.replacingOccurrences(of: "\\r\\n", with: "\n")
    }
    
    func stringToPinYin() -> String {
        
//        let kCFStringTransformStripCombiningMarks: CFString! //删除重音符号
//        let kCFStringTransformToLatin: CFString! //中文的拉丁字母
//        let kCFStringTransformFullwidthHalfwidth: CFString!//全角半宽
//        let kCFStringTransformLatinKatakana: CFString!//片假名拉丁字母
//        let kCFStringTransformLatinHiragana: CFString!//平假名拉丁字母
//        let kCFStringTransformHiraganaKatakana: CFString!//平假名片假名
//        let kCFStringTransformMandarinLatin: CFString!//普通话拉丁字母
//        let kCFStringTransformLatinHangul: CFString!//韩文的拉丁字母
//        let kCFStringTransformLatinArabic: CFString!//阿拉伯语拉丁字母
//        let kCFStringTransformLatinHebrew: CFString!//希伯来语拉丁字母
//        let kCFStringTransformLatinThai: CFString!//泰国拉丁字母
//        let kCFStringTransformLatinCyrillic: CFString!//西里尔拉丁字母
//        let kCFStringTransformLatinGreek: CFString!//希腊拉丁字母
//        let kCFStringTransformToXMLHex: CFString!//转换为XML十六进制字符
//        let kCFStringTransformToUnicodeName: CFString!//转换为Unicode的名称
//        @availability(iOS, introduced=2.0)
//        let kCFStringTransformStripDiacritics: CFString!//转换成不带音标的符号
        
        let ms = self as! CFMutableString
//        range转换的范围，nil代表全部转换。reverse是否必须是可逆向转换
        CFStringTransform(ms, nil, kCFStringTransformMandarinLatin, false)
        CFStringTransform(ms, nil, kCFStringTransformStripDiacritics, false)
        return ms as String;
    }
}


extension Dictionary where Key: ExpressibleByStringLiteral, Value: AnyObject{
    
    var jsonString: String? {
        if let dict = (self as? AnyObject) as? Dictionary<String, AnyObject> {
            do {
                let data = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions(rawValue: UInt.allZeros))
                if let string = String(data: data, encoding: String.Encoding.utf8) {
                    return string
                }
            } catch {
                print(error)
            }
        }
        return nil
    }
    
    func stringValueForKey(key: String, defaultValue: String, operation: CPStringOperationType) -> String {
        if key.characters.count > 0 {
            if let dict = (self as? AnyObject) as? Dictionary<String, AnyObject> {
                let ret = dict[key]
                if ret != nil {
                    if ret is String {
                        switch operation {
                        case .NSStringOperationTypeNone:
                            return ret as! String
                        case .NSStringOperationTypeDecodeUnicode:
                            return (ret as! String).decodeUnicode()
                        case .NSStringOperationTypeTrim:
                            return (ret as! String).trim()
                        }
                    } else if ret is NSDecimalNumber {
                        return ret as! String
                    } else if ret is NSNumber {
                        return ret as! String
                    }
                }
            }
        }
        return defaultValue
    }
}
