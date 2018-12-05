//
//  Utils.m
//  Library
//
//  Created by fanty on 13-3-28.
//  Copyright (c) 2013年 fanty. All rights reserved.
//

#import "Utils.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <sys/utsname.h>
#import <zlib.h>
#import <objc/runtime.h>


@implementation Utils
/**
 * 截取部分图像
 *
 **/
+(UIImage*)getSubImage:(UIImage *)image mCGRect:(CGRect)mCGRect centerBool:(BOOL)centerBool
{
    
    /*如若centerBool为Yes则是由中心点取mCGRect范围的图片*/
    
    
    float imgwidth = image.size.width;
    float imgheight = image.size.height;
    float viewwidth = mCGRect.size.width;
    float viewheight = mCGRect.size.height;
    CGRect rect;
    if(centerBool)
        rect = CGRectMake((imgwidth-viewwidth)/2, (imgheight-viewheight)/2, viewwidth, viewheight);
    else{
        if (viewheight < viewwidth) {
            if (imgwidth <= imgheight) {
                rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
            }else {
                float width = viewwidth*imgheight/viewheight;
                float x = (imgwidth - width)/2 ;
                if (x > 0) {
                    rect = CGRectMake(x, 0, width, imgheight);
                }else {
                    rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
                }
            }
        }else {
            if (imgwidth <= imgheight) {
                float height = viewheight*imgwidth/viewwidth;
                if (height < imgheight) {
                    rect = CGRectMake(0, 0, imgwidth, height);
                }else {
                    rect = CGRectMake(0, 0, viewwidth*imgheight/viewheight, imgheight);
                }
            }else {
                float width = viewwidth*imgheight/viewheight;
                if (width < imgwidth) {
                    float x = (imgwidth - width)/2 ;
                    rect = CGRectMake(x, 0, width, imgheight);
                }else {
                    rect = CGRectMake(0, 0, imgwidth, imgheight);
                }
            }
        }
    }
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();
    
    return smallImage;
}
+(UIColor*)colorConvertFromString:(NSString*)value{
    if ([value containsString:@"#"] == NO) {
        value = [@"#" stringByAppendingString:value];
    }
    if([value length]<7)return [UIColor whiteColor];
    
    SEL blackSel = NSSelectorFromString(value);
    if ([UIColor respondsToSelector: blackSel]){
        UIColor* color  = [UIColor performSelector:blackSel];
        if(color!=nil)
            return color;
    }
    
    NSRange range;
    range.location=1;
    range.length=2;
    NSString* r=[NSString stringWithFormat:@"0x%@",[value substringWithRange:range]];
    range.location=3;
    NSString* g=[NSString stringWithFormat:@"0x%@",[value substringWithRange:range]];
    range.location=5;
    NSString* b=[NSString stringWithFormat:@"0x%@",[value substringWithRange:range]];
    
    
    float rColor=0;
    float gColor=0;
    float bColor=0;
    float alpha=1;
    
    [[NSScanner scannerWithString:r] scanHexFloat:&rColor];
    [[NSScanner scannerWithString:g] scanHexFloat:&gColor];
    [[NSScanner scannerWithString:b] scanHexFloat:&bColor];
    
    
    rColor=rColor / 255;
    gColor=gColor / 255;
    bColor=bColor / 255;
    
    
    if([value length]==9){
        range.location=7;
        NSString* a=[NSString stringWithFormat:@"0x%@",[value substringWithRange:range]];
        
        [[NSScanner scannerWithString:a] scanHexFloat:&alpha];
        
        alpha=alpha / 255;
    }
    
    return [UIColor colorWithRed:rColor green:gColor blue:bColor alpha:alpha];
}

+(NSString *)stringFromTimetrue:(NSInteger)timeString
{
    NSTimeInterval time=timeString+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    return  [dateFormatter stringFromDate:detaildate];
    
}
+(NSString*)trim:(NSString*)value{
    return [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ];
}

+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[01678]|8[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobileNum];
}

+(BOOL) isTelephoneNumber:(NSString *)phoneNum {
    NSString * phone = @"^0\\d{2,3}[- ]?\\d{7,8}" ;
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phone];
    return [regextestmobile evaluateWithObject:phoneNum];
}
+(BOOL) isCarNumber:(NSString *)phoneNum {
    NSString * phone = @"^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$" ;
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phone];
    return [regextestmobile evaluateWithObject:phoneNum];
}


+(UIImage*)imageWithThumbnail:(UIImage *)image size:(CGSize)thumbSize{
    
    CGSize imageSize = image.size;
    
    CGFloat width = imageSize.width;
    
    CGFloat height = imageSize.height;
    
    
    CGFloat scaleFactor = 0.0;
    
    CGPoint thumbPoint = CGPointMake(0.0,0.0);
    CGFloat widthFactor = thumbSize.width / width;
    
    CGFloat heightFactor = thumbSize.height / height;
    if (widthFactor > heightFactor)  {
        scaleFactor = widthFactor;
    }
    
    else {
        
        scaleFactor = heightFactor;
        
    }
    
    CGFloat scaledWidth  = width * scaleFactor;
    
    CGFloat scaledHeight = height * scaleFactor;
    
    if (widthFactor > heightFactor){
        
        thumbPoint.y = (thumbSize.height - scaledHeight) * 0.5;
    }
    
    else if (widthFactor < heightFactor){
        thumbPoint.x = (thumbSize.width - scaledWidth) * 0.5;
    }
    UIGraphicsBeginImageContext(thumbSize);
    
    CGRect thumbRect = CGRectZero;
    
    thumbRect.origin = thumbPoint;
    
    thumbRect.size.width  = scaledWidth;
    
    thumbRect.size.height = scaledHeight;
    
    [image drawInRect:thumbRect];
    
    
    
    UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return thumbImage;
}


+(UIImage*)imageWithShadow:(UIImage *)initialImage shadowOffset:(CGSize)shadowOffset
             shadowOpacity:(float) shadowOpacity{
    
    UIColor* color=[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:shadowOpacity];
    
    
    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef shadowContext = CGBitmapContextCreate(NULL, initialImage.size.width + 10, initialImage.size.height + 10, CGImageGetBitsPerComponent(initialImage.CGImage), 0, colourSpace, 1);//kCGImageAlphaPremultipliedLast
    
    CGColorSpaceRelease(colourSpace);
    
    CGContextSetShadowWithColor(shadowContext, shadowOffset, 7, [color CGColor]);
    
    CGContextDrawImage(shadowContext, CGRectMake(5, 5, initialImage.size.width, initialImage.size.height), initialImage.CGImage);
    
    CGImageRef shadowedCGImage = CGBitmapContextCreateImage(shadowContext);
    CGContextRelease(shadowContext);
    
    UIImage * shadowedImage = [UIImage imageWithCGImage:shadowedCGImage];
    CGImageRelease(shadowedCGImage);
    
    return shadowedImage;
}

+(BOOL)isIOS7{
    return ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0f);
}

+(BOOL)isIOS8{
    return ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0f);
}

+(BOOL)isIOS10
{
    return ([[[UIDevice currentDevice] systemVersion] floatValue]>=10.0f);
}


+(NSString *)md5:(NSString*)str{
    
    if([str length]<1)
        return nil;
    
    const char *value = [str UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}



+(UIImage*)antialiasedImageOfSize:(UIImage*)image size:(CGSize)size scale:(CGFloat)scale{
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    [image drawInRect:CGRectMake(1, 1, size.width-2, size.height-2)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(NSString *)nameWithInstance:(id)instance target:(id)target
{
    unsigned int numIvars = 0;
    NSString *key=nil;
    Ivar * ivars = class_copyIvarList([target class], &numIvars);
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = ivars[i];
        const char *type = ivar_getTypeEncoding(thisIvar);
        NSString *stringType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        if (![stringType hasPrefix:@"@"]) {
            continue;
        }
        if ((object_getIvar(target, thisIvar) == instance)) {
            key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
            break;
        }
    }
    free(ivars);
    return key;
}

+(NSString *)makeOrderFKEY
{
    NSDate *dateToDay = [NSDate date];//将获得当前时间
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMdd"];
    NSString *strDate = [df stringFromDate:dateToDay];
    NSString *fkey = [self md5:[NSString stringWithFormat:@"rechargeindent%@,justgood,", strDate]];
    return fkey;
}

+(NSString *)doneOrderFKEY
{
    NSDate *dateToDay = [NSDate date];//将获得当前时间
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMdd"];
    NSString *strDate = [df stringFromDate:dateToDay];
    NSString *fkey = [self md5:[NSString stringWithFormat:@"recharge%@,justgood,", strDate]];
    return fkey;
}

+(NSString *)deviceModel
{
    if (![UIScreen instancesRespondToSelector:@selector(currentMode)]) {
        return nil;
    }
    
    if (CGSizeEqualToSize(CGSizeMake(640.0f, 960.0f),[[UIScreen mainScreen] currentMode].size))
    {
        return @"iPhone4";
    }else if (CGSizeEqualToSize(CGSizeMake(640.0f, 1136.0f),[[UIScreen mainScreen] currentMode].size)){
        return @"iPhone5";
    }else if (CGSizeEqualToSize(CGSizeMake(750.0f, 1334.0f),[[UIScreen mainScreen] currentMode].size)){
        return @"iPhone6";
    }else if (CGSizeEqualToSize(CGSizeMake(1125.0f, 2001.0f),[[UIScreen mainScreen] currentMode].size)){
        return @"iPhone6 Plus";
    }else if (CGSizeEqualToSize(CGSizeMake(1242.0f, 2208.0f),[[UIScreen mainScreen] currentMode].size)){
        return @"iPhone6 Plus";
    }else{
#ifdef DEBUG
        NSLog(@"分辨率:%f,%f",[[UIScreen mainScreen] currentMode].size.width,[[UIScreen mainScreen] currentMode].size.height);
#endif
        return nil;
    }
}

///获得设备型号
+(NSString *)getCurrentDeviceModel
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine
                                            encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}
+(NSString *)JsonModel:(NSDictionary *)dictModel
{
    if ([NSJSONSerialization isValidJSONObject:dictModel])
    {
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictModel options:NSJSONWritingPrettyPrinted error:nil];
        NSString * jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonStr;
    }
    return nil;
}

/// jsonToDic
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
//昵称

+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[A-Za-z0-9\u4e00-\u9fa5]{1,12}$";
    
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    
    return [passWordPredicate evaluateWithObject:nickname];
    
}
+ (BOOL)isChinese:(NSString *)string
{
    NSString *match = @"^[\u4e00-\u9fa5]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)includeChinese:(NSString *)string
{
    for(int i=0; i< [string length];i++)
    {
        int a =[string characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}
+ (BOOL)validatecChineseCharacter :(NSString *)name
{
    NSString *nameRegex = @"^[A-Za-z0-9\u4e00-\u9fa5]{1,20}$";
    
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nameRegex];
    
    return [passWordPredicate evaluateWithObject:name];
}


+(NSString *)stringFromDataFormatter:(NSString *)formatterStr
{
    NSDate * date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:formatterStr];
    return [formatter stringFromDate:date];
}

+(NSString *)stringFromTomorrowFormatter:(NSString *)formatterStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:formatterStr];
    return [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:24*60*60]];
}

/*车牌号验证 MODIFIED BY HELENSONG*/
+(BOOL) validateCarNo:(NSString*) carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carNo];
}

+(BOOL)isLetter:(NSString *)nameString {
    NSString * carRegex = @"^[A-Z]*$";
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    
    return [predicate evaluateWithObject:nameString];
}

+(BOOL)isNumber:(NSString *)orderString {
    NSString * carRegex = @"^[0-9]*$";
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    
    return [predicate evaluateWithObject:orderString];
}
+(BOOL)isFloat:(NSString *)orderString {
    NSString * carRegex = @"^[0-9]+([.]{0,1}[0-9]+){0,1}$";
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [predicate evaluateWithObject:orderString];
}

+(NSAttributedString *)verifyLabelWithString:(NSString *)titleString andLastString:(NSString *)lastString andImageName:(NSString *)imgNameStr imageSize:(CGSize)size
{
    if (titleString.length < 1) {
        titleString = @"";
    }
    if (lastString.length<1) {
        lastString = @"";
    }
    // 创建一个富文本
    NSMutableAttributedString *attri =     [[NSMutableAttributedString alloc] initWithString:titleString];
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:imgNameStr];
    // 设置图片大小
    if (size.width<20) {
        if ([titleString containsString:@"\n"]) {
            attch.bounds = CGRectMake(15, 8, size.width, size.height);
        }else
        {
            attch.bounds = CGRectMake(15, 1, size.width, size.height);
        }
    }else
    {
        attch.bounds = CGRectMake(0, -2, size.width, size.height);
    }
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];

    [attri appendAttributedString:string];
    [attri appendAttributedString:[[NSMutableAttributedString alloc] initWithString:lastString]];
    return attri;
}

+(NSAttributedString *)verifyLabelWithString:(NSString *)titleString andImageName:(NSString *)imgNameStr isBefor:(BOOL)befor imageSize:(CGSize)size
{
    if (titleString.length < 1) {
        titleString = @"";
    }
    // 创建一个富文本
    NSMutableAttributedString *attri =     [[NSMutableAttributedString alloc] initWithString:titleString];
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:imgNameStr];
    // 设置图片大小
    if (size.width<20) {
        if ([titleString containsString:@"\n"]) {
            attch.bounds = CGRectMake(15, 8, size.width, size.height);
        }else
        {
            attch.bounds = CGRectMake(15, 1, size.width, size.height);
        }
    }else
    {
        attch.bounds = CGRectMake(0, -2, size.width, size.height);
    }
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    
    if (befor) {
        [attri insertAttributedString:string atIndex:0];
    }else {
        [attri appendAttributedString:string];
    }
    
    return attri;
}

+(NSAttributedString *)locationWithLocationName:(NSString *)locationName imageName:(NSString *)imageName
{
    NSMutableAttributedString *attri =     [[NSMutableAttributedString alloc] initWithString:[@" " stringByAppendingString:locationName]];
    
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:imageName];
    attch.bounds = CGRectMake(0, 0, 7 , 7);
    
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:0];
    
    return attri;
}
//判断是否有emoji
+(BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar high = [substring characterAtIndex: 0];
                                
                                // Surrogate pair (U+1D000-1F9FF)
                                if (0xD800 <= high && high <= 0xDBFF) {
                                    const unichar low = [substring characterAtIndex: 1];
                                    const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
                                    
                                    if (0x1D000 <= codepoint && codepoint <= 0x1F9FF){
                                        returnValue = YES;
                                    }
                                    
                                    // Not surrogate pair (U+2100-27BF)
                                } else {
                                    if (0x2100 <= high && high <= 0x27BF){
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}



+(BOOL)textField:(UITextField *)textField InputFloatString:(NSString *)string CanContinueWithRange:(NSRange)range andTextLength:(NSInteger)textLength andFloatLength:(NSInteger)floatLength{
    //优先处理.
    if ([textField.text hasPrefix:@"."])
    {
        if ([string isEqualToString:@"."])
        {
            textField.text = @"0.0";
            return NO;
        }
        //如果输入的不是.那就在前面补0
        textField.text = [NSString stringWithFormat:@"0%@",textField.text];
        if (range.location > 1)
        {
            return NO;
        }
    }
//    if ([textField.text hasPrefix:@"0"] && ![string isEqualToString:@"."] ){
//        textField.text = [NSString stringWithFormat:@"%@.0",string];
//        return NO;
//    }
    
    NSString * text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSRange textRange = [text rangeOfString:@"."];
    if (textRange.location!= NSNotFound) {
        if ([string isEqualToString:@"."] && [textField.text containsString:@"."]) {
            return NO;
        }
        if ([text hasPrefix:@"0"] && textRange.location!=1) {
            return NO;
        }
        NSInteger laterLength = text.length-textRange.location-1;
        if (textRange.location>textLength || laterLength>floatLength) {
            return NO;
        }
    }else{
        if ([text hasPrefix:@"0"] && text.length>1) {
            return NO;
        }
        if (text.length>textLength) {
            return NO;
        }
    }
    return YES;
}

//-(void)mayBeUse
//{
//    NSString *hanziText = @"我是中国人AAA";
//    if ([hanziText length]) {
//        NSMutableString *ms = [[NSMutableString alloc] initWithString:hanziText];
//        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
//            NSLog(@"pinyin: %@", ms);
//        }
//        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
//            NSLog(@"pinyin: %@", ms);
//        }
//    }
//}



/*- (id)initWithCoder:(NSCoder *)aDecoder {
     if (self = [super init]) {
         unsigned int outCount;
         Ivar * ivars = class_copyIvarList([self class], &outCount);
         for (int i = 0; i < outCount; i ++) {
             Ivar ivar = ivars[i];
             NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
             [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
         }
     }
     return self;
 }
  
 - (void)encodeWithCoder:(NSCoder *)aCoder {
     unsigned int outCount;
     Ivar * ivars = class_copyIvarList([self class], &outCount);
     for (int i = 0; i < outCount; i ++) {
         Ivar ivar = ivars[i];
         NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
         [aCoder encodeObject:[self valueForKey:key] forKey:key];
     }
 }*/
@end
