//
//  UITextView+DisableCopy.h
//  HurricaneTravel
//
//  Created by 秦赟 on 2019/11/19.
//  Copyright © 2019 HurricaneTravel. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (DisableCopy)
@property(nonatomic,assign) BOOL isAllowPaste;
-(void)setIsAllowPaste:(BOOL)isAllowPaste;
-(BOOL)isAllowPaste;
@end

NS_ASSUME_NONNULL_END
