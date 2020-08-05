//
//  UITextView+DisableCopy.m
//  HurricaneTravel
//
//  Created by 秦赟 on 2019/11/19.
//  Copyright © 2019 HurricaneTravel. All rights reserved.
//

#import "UITextView+DisableCopy.h"
#import <objc/runtime.h>


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


