//
//  TBCycleView.m
//  TBCycleProgress
//
//  Created by qianjianeng on 16/2/22.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "TBCycleView.h"
#import "Utils.h"
@interface TBCycleView ()

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, strong) CAShapeLayer *progressTwo;

@end
@implementation TBCycleView

- (void)drawProgress:(CGFloat )progress
{
    _progress = progress;
    _progressTwo.opacity = 0;
    [self drawWithShapeLayer];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

-(void)drawWithShapeLayer{
    CGSize size = self.frame.size;
    NSString * one = @"fea546";
    NSString * two = @"fd753f";
    NSString * three = @"fb3131";
    if (_progress>1.01 && _progress<=2) {
        one = @"fb3131";
        two = @"eb2a2a";
        three = @"c60b0b";
        _progress -= 1;
    }else if (_progress>2.01)
    {
        _progress-=2;
        one = @"c60b0b";
        two = @"c60b0b";
        three = @"c60b0b";
    }

    CGPoint center = CGPointMake(size.width/2, size.height/2);
    CGFloat radius = self.frame.size.height/2-10;
    CGFloat startA = 0;  //设置进度条起点位置
    CGFloat endA = M_PI * 2 * (_progress-floorf(_progress));
    if (fabs(_progress-floorf(_progress))<0.02 && _progress>=1) {
        endA = M_PI * 2;
    }

    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];//上面说明过了用来构建圆形
    //获取环形路径（画一个圆形，填充色透明，设置线框宽度为10，这样就获得了一个环形）
    CGFloat dashLineConfig[] = {8.0, 4.0};
    [path setLineDash:dashLineConfig count:50 phase:0.5];
    _progressTwo = [CAShapeLayer layer];//创建一个track shape layer
    _progressTwo.frame = CGRectMake(0, 0, size.width, size.height);
    _progressTwo.fillColor = [[UIColor clearColor] CGColor];  //填充色为无色
    _progressTwo.strokeColor = [[Utils colorConvertFromString:@"c60b0b"] CGColor]; //指定path的渲染颜色,这里可以设置任意不透明颜色
    _progressTwo.opacity = 1; //背景颜色的透明度
//        _progressTwo.lineCap = kCALineCapRound;//指定线的边缘是圆的
    _progressTwo.lineWidth = 10;//线的宽度
    _progressTwo.path =[path CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。
    [self.layer addSublayer:_progressTwo];
    
    CALayer *gradientLayer2 = [CALayer layer];
    //xia渐变色
    CAGradientLayer *top = [CAGradientLayer layer];
    top.frame = CGRectMake(0, 0, size.width , size.height/2);
    top.startPoint = CGPointMake(0, 0.5);
    top.endPoint = CGPointMake(1, 0.5);
    [gradientLayer2 addSublayer:top];
    top.colors = @[(id)[[Utils colorConvertFromString:two] colorWithAlphaComponent:1].CGColor, (id)[[Utils colorConvertFromString:two] colorWithAlphaComponent:1].CGColor];
    //shang渐变色
    CAGradientLayer *bottom = [CAGradientLayer layer];
    bottom.frame = CGRectMake(0, self.bounds.size.height/2, self.bounds.size.width , self.bounds.size.height/2);
    bottom.startPoint = CGPointMake(1, 0.5);
    bottom.endPoint = CGPointMake(0, 0.5);
    bottom.colors = @[(id)[[Utils colorConvertFromString:two] colorWithAlphaComponent:1].CGColor, (id)[[Utils colorConvertFromString:two] colorWithAlphaComponent:1].CGColor];
    [gradientLayer2 addSublayer:bottom];
    if (_progress<=2) {
        [gradientLayer2 setMask:_progressTwo]; //用progressLayer来截取渐变层
        [self.layer addSublayer:gradientLayer2];
    }

}

@end
