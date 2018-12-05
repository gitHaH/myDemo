//
//  Utils.h
//  Library
//
//  Created by fanty on 13-3-28.
//  Copyright (c) 2013年 fanty. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreen_Height   [[UIScreen mainScreen] bounds].size.height
#define kScreen_Width    [[UIScreen mainScreen] bounds].size.width

//通用方法收集类
@interface Utils : NSObject

//颜色值转换UIColor ，如#ffffff转  whiteColor
+(UIColor*)colorConvertFromString:(NSString*)value;

//截取字符串
+(NSString*)trim:(NSString*)value;
+(NSString *)stringFromTimetrue:(NSInteger)timeString;
//生成缩略图
+(UIImage*)imageWithThumbnail:(UIImage *)image size:(CGSize)thumbSize;
+(UIImage*)getSubImage:(UIImage *)image mCGRect:(CGRect)mCGRect centerBool:(BOOL)centerBool;

//生成带阴影图
+(UIImage*)imageWithShadow:(UIImage *)initialImage shadowOffset:(CGSize)shadowOffset
             shadowOpacity:(float) shadowOpacity;

//是否有效email
+(BOOL)isValidateEmail:(NSString *)email;

//是否有效phone
+(BOOL)isMobileNumber:(NSString *)mobileNum;
///老司机合格证书
+(BOOL) isCarNumber:(NSString *)phoneNum;
//是否有效固定电话号码
+(BOOL) isTelephoneNumber:(NSString *)string;

//判断是否ios7以上版本
+(BOOL)isIOS7;

//判断是否ios8以上版本
+(BOOL)isIOS8;

//判断是否ios10以上版本
+(BOOL)isIOS10;

//md5编码一个字符串
+(NSString *)md5:(NSString*)str;

//3des加密
+(NSString*)TripleDES:(NSString*)plainText desKey:(NSString*)desKey;

//为图片增加一个边缘透明像素，抗据齿
+(UIImage*)antialiasedImageOfSize:(UIImage*)image size:(CGSize)size scale:(CGFloat)scale;

//根据变量的引用获取变量名
+(NSString *)nameWithInstance:(id)instance target:(id)target;

/*生成运单fkey*/
+(NSString *)makeOrderFKEY;

/*交易完成fkey*/
+(NSString *)doneOrderFKEY;

+(NSString *)deviceModel;

+(NSString *)getCurrentDeviceModel;
+(NSString *)JsonModel:(NSDictionary *)dictModel;
/// jsonToDic
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (BOOL)isChinese:(NSString *)string;
+ (BOOL)includeChinese:(NSString *)string;
//昵称
+ (BOOL) validateNickname:(NSString *)nickname;
//汉字
+ (BOOL)validatecChineseCharacter :(NSString *)name;
///日期
+(NSString *)stringFromDataFormatter:(NSString *)formatterStr;
+(BOOL) validateCarNo:(NSString*) carNo;
///是否整形或小数
+(BOOL)isFloat:(NSString *)orderString;
///判断是否为字母
+(BOOL)isLetter:(NSString *)nameString;
///判断是否为数字
+(BOOL)isNumber:(NSString *)orderString;

+(NSAttributedString *)verifyLabelWithString:(NSString *)titleString andImageName:(NSString *)imgNameStr isBefor:(BOOL)befor imageSize:(CGSize)size;
+(NSAttributedString *)verifyLabelWithString:(NSString *)titleString andLastString:(NSString *)lastString andImageName:(NSString *)imgNameStr imageSize:(CGSize)size;
+(NSAttributedString *)locationWithLocationName:(NSString *)locationName imageName:(NSString *)imageName;
///是否有emoj
+(BOOL)stringContainsEmoji:(NSString *)string;
///打电话
+(void)showNumberWithLocation:(NSString *)location withNumber:(NSString *)number;

+(BOOL)textField:(UITextField *)textField InputFloatString:(NSString *)string CanContinueWithRange:(NSRange)range andTextLength:(NSInteger)textLength andFloatLength:(NSInteger)floatLength;
@end
