//
//  UITextView+DisableCopy.m
//  HurricaneTravel
//
//  Created by 秦赟 on 2019/11/19.
//  Copyright © 2019 HurricaneTravel. All rights reserved.
//

#import "UITextView+DisableCopy.h"
#import <objc/runtime.h>
@interface JsonPaser : NSObject
-(void)paser;
@end
@implementation JsonPaser
-(void)paser{
    Class  class = NSClassFromString(@"Model");
    id cla = [[class alloc] init];
    NSArray * properties = [self propertiesFromClass:class];
    NSDictionary * dic = @{@"name":@"jac",@"age":@16,@"page":@"2"};
    [self class:cla fromDic:dic properties:properties];
    NSLog(@"");
}

-(NSArray *)propertiesFromClass:(Class)class{
    NSMutableArray * nameList = [NSMutableArray array];
    NSMutableArray * propertyList = [NSMutableArray array];
    do {
        unsigned int outCount,i,mc;
        objc_property_t * properties = class_copyPropertyList(class, &outCount);
        Method *m = class_copyMethodList(class, &mc);
        for (i = 0; i<mc; i++) {
             Method a = m[i];
            const char* astr = sel_getName(method_getName(a));
            
            
        }
        for (i = 0; i<outCount; i++) {
            objc_property_t property = properties[i];
            NSString * eachName = [[NSString alloc]initWithUTF8String:property_getName(property)];
            NSString * eachAtt = [[NSString alloc] initWithUTF8String:property_getAttributes(property)];
            [nameList addObject:eachName];
            [propertyList addObject:eachAtt];
        }
        free(properties);
        class = [class superclass];
    } while ([NSStringFromClass(class) isEqualToString:@"NSObject"]==NO);
    return @[nameList,propertyList];
}

-(void)class:(id)serialObject fromDic:(NSDictionary*)dic properties:(NSArray *)properties{
    for (int i = 0; i<[properties[0] count]; i++) {
        NSString * name = properties[0][i];
        NSString * property = properties[1][i];
        NSString * proName = name;
        id value = dic[name];
        if ([value isKindOfClass:[NSString class]]) {
            if ([property containsString:@"NSString"]) {
                [serialObject setValue:value forKey:proName];
            }
            else{
                NSLog(@"数据类型错误");
            }
        }else if ([value isKindOfClass:[NSNumber class]]){
            if ([property containsString:@"NSString"]) {
                NSLog(@"数据类型错误");
            }
            else{
                [serialObject setValue:value forKey:name];
            }
        }else{
            
        }
    }
}
@end


@implementation UITextView (DisableCopy)
static BOOL _isAllowPaste;
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    //一旦双击，里面禁用。取消第一响应者，设置不可交互。
//    [self resignFirstResponder];
//    self.userInteractionEnabled = NO;
    NSArray * arr = @[@"ViewController1",@"ViewController2",@"ViewController3"];
    UINavigationController * nav = (UINavigationController *)UIApplication.sharedApplication.keyWindow.rootViewController;
    UIViewController * vc = nav.topViewController;
    NSString * currentName = NSStringFromClass(vc.classForCoder);
    BOOL isAllow = [arr containsObject:currentName];
    JsonPaser * p = [[JsonPaser alloc] init];
    [p paser];
    
    if (isAllow) {
        return YES;
    }
    
    if (self.isAllowPaste) {
        return YES;
    }
    if ([UIMenuController sharedMenuController])
    {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }

    return NO;
}

-(void)setIsAllowPaste:(BOOL)isAllowPaste{
    NSNumber *t = @(isAllowPaste);
    // void objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
    objc_setAssociatedObject(self, &_isAllowPaste, t, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(BOOL)isAllowPaste{
    NSNumber *t = objc_getAssociatedObject(self, &_isAllowPaste);
    return [t boolValue];
}

@end


@interface Model : NSObject
@property(nonatomic,copy) NSString *name;
@property(nonatomic,assign) int age;
-(void)a;
@end

@implementation Model
-(void)a{
    
}
@end

@interface Model (DisableCopy)
-(void)b;
@end

@implementation Model(DisableCopy)
-(void)b{
    NSLog(@"a");
}
@end

@interface Model (DisableCop)
-(void)b;
@end

@implementation Model(DisableCop)
-(void)b{
    NSLog(@"b");
}
@end
