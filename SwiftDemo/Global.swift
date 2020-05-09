//
//  Global.swift
//  yunduoketang
//
//  Created by wangfei-sal on 16/4/16.
//  Copyright © 2016年 fwang. All rights reserved.
//

import Foundation
import UIKit
var courseSearchText_color = UIColor.init(red: 99/255.0, green: 219/255.0, blue: 255/255.0, alpha: 1)//99,219,255 #63dbff
var courseSearchBackground_color = UIColor.init(red: 1/255.0, green: 173/255.0, blue: 255/255.0, alpha: 1)//1,173,225 #01ade1

func UIColorFromRGB(_ rgbValue:Int32)->UIColor
{
    return UIColor.init(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green:((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0, blue:((CGFloat)(rgbValue & 0xFF))/255.0, alpha: 1)
}

func __RGBA(_ rgbValue:Int, alpha: CGFloat) ->UIColor
{
    return UIColor.init(red: CGFloat((rgbValue & 0xFF0000) >> 16)/255.0, green: CGFloat((rgbValue & 0xFF00) >> 8)/255.0, blue: CGFloat(rgbValue & 0xFF)/255.0, alpha: alpha)
}

func __RGB(_ rgbValue:Int) ->UIColor
{
    return UIColor.init(red: CGFloat((rgbValue & 0xFF0000) >> 16)/255.0, green: CGFloat((rgbValue & 0xFF00) >> 8)/255.0, blue: CGFloat(rgbValue & 0xFF)/255.0, alpha: 1)
}

let __SCREEN_BOUNDS = UIScreen.main.bounds
let __SCREEN_SIZE = UIScreen.main.bounds.size
let __SCREEN_BOUNDS_SIZE_CHAGE = CGRect(x: 0, y: 0, width: __SCREEN_SIZE.height, height: __SCREEN_SIZE.width)

//let __iPhoneX = (__CGSizeEqualToSize(CGSize(width: 375, height: 812), __SCREEN_SIZE) || __CGSizeEqualToSize(CGSize(width: 812, height: 375), __SCREEN_SIZE))
//let __StatusBarH = CGFloat(__ ? 44:20)

func CGScaleXC(_ __v__ : CGFloat) -> CGFloat { return (__SCREEN_SIZE.width - ceil((__v__*(__SCREEN_SIZE.width/375.0))))*0.5 }
func CGScaleX(_ __v__ : CGFloat) -> CGFloat { return round((__v__*(__SCREEN_SIZE.width/375.0))) }
func CGScale(_ __v__ : CGFloat) -> CGFloat { return ceil((__v__*(__SCREEN_SIZE.width/375.0))) }
func CGScaleSize(_ __w__ : CGFloat, _ __h__ : CGFloat) -> CGSize  { return CGSize(width: CGScale(__w__), height: CGScale(__h__)) }
func CGScaleRect(_ __x__ : CGFloat, _ __y__ : CGFloat, _ __w__ : CGFloat, _ __h__ : CGFloat) ->CGRect { return CGRect(x: CGScale(__x__), y: CGScale(__y__), width: CGScale(__w__), height: CGScale(__h__)) }

func VIEWX(_ __view : UIView) -> CGFloat { return (__view.frame.origin.x) }
func VIEWY(_ __view : UIView) -> CGFloat { return (__view.frame.origin.y) }
func VIEWW(_ __view : UIView) -> CGFloat { return (__view.frame.size.width) }
func VIEWH(_ __view : UIView) -> CGFloat { return (__view.frame.size.height) }
func VIEWMaxX(_ __view : UIView) -> CGFloat { return (__view.frame.origin.x + __view.frame.size.width) }
func VIEWMaxY(_ __view : UIView) -> CGFloat { return (__view.frame.origin.y + __view.frame.size.height) }

func DoubleEqual(_ A:CGFloat,_ B:CGFloat) -> Bool{
    return (fabs(A-B)<0.001)
}



let kNotificationDeeplinkCourse = Notification.Name(rawValue: "DeeplinkCourse")
let kNotificationCachesManageRemoveAll = NSNotification.Name(rawValue: "CachesManageRemoveAll")
let kNotificationGetCurrtCopany = NSNotification.Name(rawValue: "kNotificationGetCurrtCopany")
let kNotificationRefreshCourse =  NSNotification.Name(rawValue: "refreshCourse")

let kNotificationQueryMyOrder = NSNotification.Name(rawValue: "queryMyOrder")
let kNotificationQueryMyCourse = NSNotification.Name(rawValue: "queryMyCourse")
let kNotificationQueryMyAccount = NSNotification.Name(rawValue: "myAccount")
let kNotificationQueryMyMember = NSNotification.Name(rawValue: "queryMember")

let UD_AudioKey = "audioNeedStop"

let VERSION = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
let BUILDVERSION = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
let BUNDLEID = Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String


public let COLOR_BKG = __RGB(0xf6f6f6)
public let CGRectMin = CGRect(x: 0, y: 0, width: 0, height: 0.001)

//
public func __iPhoneX() -> Bool {
    guard #available(iOS 11.0, *) else {
        return false
    }
    return UIApplication.shared.windows[0].safeAreaInsets.bottom > 0
}
public let __StatusBarH = CGFloat(false ? (__iPhoneX() ? 24:20) : (__iPhoneX() ? 44:20))
public let __NavNotStatusH = CGFloat(false ? 50 : 44)//ipad navheight=50
public let __NavHeight = __StatusBarH+__NavNotStatusH
public let __NavH = __NavHeight
