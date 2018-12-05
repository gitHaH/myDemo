//
//  FWDeviceInfo.m
//  IOS_SDK
//
//  Created by wangfei-sal on 15/12/10.
//  Copyright © 2015年 360.cn. All rights reserved.
//
#import "FWDeviceInfo.h"

#import <UIKit/UIKit.h>
#import <AdSupport/AdSupport.h>
#import <SystemConfiguration/CaptiveNetwork.h> // ssid

#include <sys/types.h>
#include <sys/sysctl.h>//deviceType

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#import <sys/stat.h>//checkCydia
#import <dlfcn.h>//checkInject
#import <mach-o/dyld.h>//checkDylibs



@implementation FWDeviceInfo
{
    CLLocationManager *locationManager;
}
@synthesize location,enableLocation,networkState;

static FWDeviceInfo *_shareInstance = nil;
+ (FWDeviceInfo *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[self alloc] init];
    });
    return _shareInstance;
}
+(id) allocWithZone:(NSZone *)zone
{
    @synchronized(self){
        if (_shareInstance == nil) {
            _shareInstance = [super allocWithZone:zone];
            return  _shareInstance;
        }
    }
    return nil;
}

-(NSString *)htmls:(NSString *)urlString{
    NSError *err = nil;
    NSURL * url = [NSURL URLWithString:urlString];
    NSString *htmlString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&err];
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n" options:0 error:nil];
    return  [regularExpretion stringByReplacingMatchesInString:htmlString options:NSMatchingReportProgress range:NSMakeRange(0, htmlString.length) withTemplate:@""];

}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
- (instancetype)init
{
    if (self = [super init])
    {
        location=CLLocationCoordinate2DMake(0,0);
        enableLocation=YES;
       // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kFWReachabilityChangedNotification object:nil];
       // 
    }
    return self;
}
- (nonnull NSString*)appName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey];
}
- (nonnull NSString*)bundleID
{
    return [NSBundle mainBundle].bundleIdentifier;
}
- (nonnull NSString*)appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
- (nonnull NSString*)systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

- (nonnull NSString*)BSSID
{
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSString*_BSSID=@"";
    for (NSString *ifnam in ifs)
    {
        NSDictionary* networkInfo = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (networkInfo)
        {
            _BSSID=networkInfo[@"BSSID"];
            break;
        }
    }
    return _BSSID;
}
- (nonnull NSString*)SSID
{
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSString*_SSID=@"";
    for (NSString *ifnam in ifs)
    {
        NSDictionary* networkInfo = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (networkInfo)
        {
            _SSID=networkInfo[@"SSID"];
            break;
        }
    }
    return _SSID;
}
-(nonnull NSString*)deviceName
{
    return [[UIDevice currentDevice] name];
}
-(nonnull NSString*)deviceType
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}
-(nonnull NSNumber*)screenH
{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    /*for ipad分屏,只取当前app的屏幕分辨率*/
    if ([UIApplication sharedApplication].keyWindow) {
        size = [UIApplication sharedApplication].keyWindow.frame.size;
    }
    return @(MIN(size.width*[[UIScreen mainScreen] scale],size.height*[[UIScreen mainScreen] scale]));
}
-(nonnull NSNumber*)screenW
{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    /*for ipad分屏,只取当前app的屏幕分辨率*/
    if ([UIApplication sharedApplication].keyWindow) {
        size = [UIApplication sharedApplication].keyWindow.frame.size;
    }
    return @(MAX(size.width*[[UIScreen mainScreen] scale],size.height*[[UIScreen mainScreen] scale]));
}

-(nonnull NSString*)screenDisplay
{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    /*for ipad分屏,只取当前app的屏幕分辨率*/
    if ([UIApplication sharedApplication].keyWindow) {
        size = [UIApplication sharedApplication].keyWindow.frame.size;
    }
    return [NSString stringWithFormat:@"%.0fx%.0f",MIN(size.width*[[UIScreen mainScreen] scale],size.height*[[UIScreen mainScreen] scale]),MAX(size.width*[[UIScreen mainScreen] scale],size.height*[[UIScreen mainScreen] scale])];
}
-(nonnull NSNumber*)deviceScale
{
    return @([[UIScreen mainScreen] scale]);
}
-(nonnull NSNumber*)orientation
{
     UIInterfaceOrientation _orientation=[[UIApplication sharedApplication] statusBarOrientation];
    if(UIInterfaceOrientationIsPortrait(_orientation))
    {
        return @(2);
    }
    if(UIInterfaceOrientationIsLandscape(_orientation))
    {
        return @(1);
    }
    return @(0);
}
-(nonnull NSString*)carrierType
{
    NSString* _operators=@"na";
    if (NSClassFromString(@"CTTelephonyNetworkInfo"))
    {
        CTCarrier *carrier = [[CTTelephonyNetworkInfo alloc] init].subscriberCellularProvider;
        if (carrier)
        {
            if ([[carrier carrierName] length]>0)
            {
                _operators = [carrier carrierName];
            }
        }
    }
    return _operators;
}
#pragma mark 是否越狱
static int checkCydia(void)
{
    int ret =-1;
    struct stat stat_info;
    ret=stat("/Applications/Cydia.app", &stat_info);
    if (0 != ret) {
        ret = stat("/Library/MobileSubstrate/MobileSubstrate.dylib", &stat_info);
    }
    return ret;
}
static int checkInject(void)
{
    int ret =-1;
    Dl_info dylib_info;
    int (*func_stat)(const char *, struct stat *) = stat;
    if ((ret = dladdr(func_stat, &dylib_info)))
    {
       // NSLog(@"lib :%s", dylib_info.dli_fname);
        ret=strcmp("/usr/lib/system/libsystem_kernel.dylib", dylib_info.dli_fname);
    }
    return ret;
}
static int checkDylibs(void)
{
    int ret =-1;
    uint32_t count = _dyld_image_count();
    for (uint32_t i = 0 ; i < count; ++i)
    {
        ret=strcmp("Library/MobileSubstrate/MobileSubstrate.dylib", _dyld_get_image_name(i));
       // NSLog(@"--%s", _dyld_get_image_name(i));
        if (ret==0) {
            break;
        }
    }
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    //NSLog(@"checkDylibs--%s", env);
    return ret;
}
-(nonnull NSNumber*)jailBroken
{
    int ret =0;
    if(checkCydia()==0)
    {
        ret=1;
    }
    else if(checkInject()==0)
    {
        ret=1;
    }
    else if(checkDylibs()==0)
    {
        ret=1;
    }
    return @(ret);
}

@end
