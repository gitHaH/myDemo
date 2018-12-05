//
//  ZZZMyButton.m
//  SwiftDemo
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZZZMyButton.h"

@implementation ZZZMyButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"-----%@", [NSString stringWithFormat:@"x = %.2f  y = %.2f",point.x,point.y]);
    CGRect bounds = self.bounds;
    bounds = CGRectMake(-60, -60, self.frame.size.width+120, self.frame.size.height+120);//CGRectInset(bounds, -60, -60);
    return CGRectContainsPoint(bounds, point);
}
@end
