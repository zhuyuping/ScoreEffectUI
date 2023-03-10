//
//  Extensions.swift
//  ScoreEffectUI
//
//  Created by ZYP on 2022/12/21.
//

import Foundation

class ScoreEffectUI {}


extension Bundle {
    static var currentBundle: Bundle {
        let bundle = Bundle(for: ScoreEffectUI.self)
        let path = bundle.path(forResource: "ScoreEffectUIBundle", ofType: "bundle")
        if path == nil {
            fatalError("bundle not found path")
        }
        let current = Bundle(path: path!)
        if current == nil {
            fatalError("bundle not found path: \(path!)")
        }
        return current!
    }
    
    func image(name: String) -> UIImage? {
        return UIImage(named: name, in: self, compatibleWith: nil)
    }
}

extension UIColor{
    class func colorWithHex(hexStr:String) -> UIColor{
        return UIColor.colorWithHex(hexStr : hexStr, alpha:1)
    }
    
    class func colorWithHex(hexStr:String, alpha:Float) -> UIColor{
        
        var cStr = hexStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased() as NSString;
        
        if(cStr.length < 6){
            return UIColor.clear;
        }
        
        if(cStr.hasPrefix("0x")){
            cStr = cStr.substring(from: 2) as NSString
        }
        
        if(cStr.hasPrefix("#")){
            cStr = cStr.substring(from: 1) as NSString
        }
        
        if(cStr.length != 6){
            return UIColor.clear
        }
        
        let rStr = (cStr as NSString).substring(to: 2)
        let gStr = ((cStr as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bStr = ((cStr as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        
        Scanner.init(string: rStr).scanHexInt32(&r)
        Scanner.init(string: gStr).scanHexInt32(&g)
        Scanner.init(string: bStr).scanHexInt32(&b)
        
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(alpha));
        
    }
}
