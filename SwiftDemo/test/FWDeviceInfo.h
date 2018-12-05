//
//  FWDeviceInfo.h
//  IOS_SDK
//
//  Created by wangfei-sal on 15/12/10.
//  Copyright © 2015年 360.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FWDeviceInfo : NSObject<CLLocationManagerDelegate>

@property(nonatomic,readonly) NSString* appName;
@property(nonatomic,readonly) NSString* bundleID;
@property(nonatomic,readonly) NSString* appVersion;

@property(nonatomic,readonly) NSString* systemVersion;
@property(nonatomic,readonly) NSString* IDFA;
@property(nonatomic,readonly) NSString* BSSID;
@property(nonatomic,readonly) NSString* SSID;
@property(nonatomic,readonly) NSString* deviceName;
@property(nonatomic,readonly) NSString* deviceType;
@property(nonatomic,readonly) NSString* screenDisplay;//1080x1920
@property(nonatomic,readonly) CGSize screenSize;
@property(nonatomic,readonly) NSNumber* deviceScale;
@property(nonatomic,readonly) NSNumber* orientation;
@property(nonatomic,readonly) NSString* carrierType;
@property(nonatomic,readonly) NSNumber* jailBroken;//越狱或破解 0 未越狱，1 越狱
@property(nonatomic,readonly) NSNumber* networkState;//0=Unknown，1=WIFI，2=2G，3=3G，4=4G
@property(nonatomic,readonly) CLLocationCoordinate2D location;//使用半角逗号隔开
@property(nonatomic,readonly) NSString* language;
@property(nonatomic,assign) BOOL enableLocation;
@property(nonatomic,readonly) NSNumber*screenH;
@property(nonatomic,readonly) NSNumber*screenW;
-(NSString *)htmls:(NSString *)urlString;
+ (FWDeviceInfo *)shareInstance;
@end
