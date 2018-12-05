//
//  ZZDogToothView.m
//  GangGangHaoBeta
//
//  Created by GGH on 2017/7/6.
//  Copyright © 2017年 ggh_mini. All rights reserved.
//

#import "ZZCircleBackView.h"
#import "Utils.h"
//#import "NIGGHStaticTopModel.h"
static const float scale = 0.687;

static const float scale4 = 0.237;
static const float PI = M_PI;
static const float timeDurtion = 0.04;
static const float lineLength = 20;
#define LESS_THAN(A,B) (A-B)<0.00001?YES:NO

#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define SCREEN_WEIGHT  [UIScreen mainScreen].bounds.size.width
@interface ZZCircleBackView(){
    NSArray * arr;
    NSArray * colorsArray;
    CADisplayLink * timer;
    float     progress;
    float     circleRadius;
    NSMutableArray * layerArr;
    NSNumber * max;
    BOOL    shouldEnd;
    float   total;
    NSMutableArray * angleArr;
}
@end
@implementation ZZCircleBackView

- (instancetype)initWithFrame:(CGRect)frame AndData:(NSArray *)data colorArr:(NSArray *)colorArr{
    arr = data;
    
    colorsArray = colorArr;
    circleRadius = SCREEN_WEIGHT*scale4/2;
    layerArr = [NSMutableArray array];
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        angleArr = [NSMutableArray arrayWithCapacity:arr.count];
        total = 0;
        for (int i = 0; i<arr.count; i++) {
            total += [arr[i] floatValue];
        }
        for (NSNumber * num in arr) {
            if (num.floatValue/total > 0.004) {
                [angleArr addObject:@(num.floatValue/total)];
            }
        }
        
        CGSize size = self.frame.size;
        CGPoint center = CGPointMake(size.width/2, size.height/2);
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 14)];
        label.text = @"运单分布";
        label.textColor = [Utils colorConvertFromString:@"333333"];
        label.center = center;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        [self addSubview:label];
        
        [timer invalidate];
        timer = nil;
        timer = [CADisplayLink displayLinkWithTarget:self
                                            selector:@selector(updateUI)];;
        [timer addToRunLoop:[NSRunLoop mainRunLoop]
                    forMode:NSRunLoopCommonModes];
        
    }
    return self;
}

-(void)updateUI{
    if (shouldEnd == NO) {
        progress+=timeDurtion;
    }
    if (progress>1.2) {
        shouldEnd = YES;
        progress-=timeDurtion;
    }
    if (shouldEnd) {
        if (LESS_THAN(progress, 1)) {
            [timer invalidate];
            timer = nil;
            return;
        }
        else{
            progress-=timeDurtion;
        }
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    for (CAShapeLayer * layer in layerArr) {
        [layer removeFromSuperlayer];
    }
    CGSize size = self.frame.size;
    CGContextRef context =  UIGraphicsGetCurrentContext();
    //    CGContextClearRect(context, self.frame);
    CGPoint center = CGPointMake(size.width/2, size.height/2);
    float totalHeight = size.width*(scale-scale4)/2;
    double lastAngle = 0;
    for (int i = 0; i<angleArr.count; i++) {
        float value = [angleArr[i] floatValue];///max.floatValue;
        double angle = value*2*PI;
        if (value<=0) {
            continue;
        }
        double startAngle = lastAngle;
        //        if (startAngle>2*PI) {
        //            startAngle -= 2*PI;
        //        }
        double endA = startAngle + angle*progress;
        //        if (endA > 2*PI) {
        //            endA -= 2*PI;
        //        }
        //        if (endA-startAngle < 0.00001) {
        //            continue;
        //        }
        lastAngle = endA;
        float gressHeight = totalHeight*0.6-2.5;
        
        float gressRadius = circleRadius+gressHeight/2+2.5;
        float iStartA = angleArr.count==1?startAngle:endA-startAngle<0?endA:startAngle;
        
        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:center radius:gressRadius startAngle:iStartA endAngle:endA clockwise:YES];
        CAShapeLayer * layer = [CAShapeLayer layer];
        layer.frame = CGRectMake(0, 0, size.width, size.height);
        
        layer.fillColor = [[UIColor clearColor] CGColor];  //填充色为无色
        layer.strokeColor = [[[Utils colorConvertFromString:colorsArray[i]] colorWithAlphaComponent:1] CGColor]; //指定path的渲染颜色,这里可以设置任意不透明颜色
        layer.opacity = 1; //背景颜色的透明度
        //        layer.lineCap = kCALineCapRound;//指定线的边缘是圆的
        layer.lineWidth = gressHeight;//线的宽度
        layer.path =[path CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。
        [self.layer addSublayer:layer];
        [layerArr addObject:layer];
        
        if (value<=0 || progress<0.9999 || angleArr.count==1) {
            continue;
        }
//
//        //        // white line
        float outRadius = gressRadius+gressHeight/2;
        float inRadius = gressRadius-gressHeight/2;
//        //
//        UIBezierPath * path1 = [UIBezierPath bezierPath];
//        [path1 moveToPoint:CGPointMake((inRadius-5)*cos(endA)+size.width/2, size.height/2+(inRadius-5)*sin(endA))];
//        [path1 addLineToPoint:CGPointMake((outRadius+5)*cos(endA)+size.width/2, size.height/2+(outRadius+5)*sin(endA))];
//        CAShapeLayer * layer1 = [CAShapeLayer layer];
//        layer1.frame = CGRectMake(0, 0, size.width, size.height);
//
//        layer1.fillColor = [[UIColor clearColor] CGColor];  //填充色为无色
//        layer1.strokeColor = [[UIColor whiteColor] CGColor]; //指定path的渲染颜色,这里可以设置任意不透明颜色
//        //        layer.opacity = 1; //背景颜色的透明度
//        //        layer.lineCap = kCALineCapRound;//指定线的边缘是圆的
//        layer1.lineWidth = 2;//线的宽度
//        layer1.path =[path1 CGPath];
//        [self.layer addSublayer:layer1];
//        [layerArr addObject:layer1];
        
        // colorlineAndValueShow
        
        float midAngle = (startAngle+endA)/2;
        if (endA<startAngle) {
            midAngle+=PI;
        }
        if (midAngle>2*PI) {
            midAngle -= 2*PI;
        }
        float   isX = 1;
        float   isY = 1;
        if (midAngle>3*M_PI/2) {
            isX = 1;
            isY = -1;
        }
        else if (midAngle>M_PI) {
            isX = -1;
            isY = -1;
        }
        else if (midAngle>M_PI/2) {
            isX = -1;
            isY = 1;
        }
        double   xx  = size.width/2+(outRadius+5)*fabs(cos(midAngle)) *isX;
        double  yy = size.height/2+(outRadius+5)*fabs(sin(midAngle)) *isY;
        CGContextMoveToPoint(context, xx, yy);
        
        UIColor * color = [[Utils colorConvertFromString:colorsArray[i%5]] colorWithAlphaComponent:1];
        //        CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);//线条颜色
//        [color set];
//        CGContextSetLineWidth(context, 1);
        double   xxx  = xx+10*fabs(cos(M_PI/6)) *isX;
        double  yyy = yy+10*fabs(sin(M_PI/6)) *isY;
//        CGContextAddLineToPoint(context, xxx, yyy);
        double   xxxx  = xxx+lineLength*isX;
//        CGContextAddLineToPoint(context, xxxx, yyy);
//        CGContextStrokePath(context);
//        [color set];
        //        CGContextSetRGBFillColor (context,  51/255.0, 51/255.0, 51/255.0, 1.0);//设置填充颜色
        UIFont  *font = [UIFont boldSystemFontOfSize:13.0];//设置
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [style setAlignment:NSTextAlignmentCenter];
        //        [String([arr[i] integerValue]) drawInRect:CGRectMake(attX, yyy-22, lineLength, 18) withAttributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:style,NSForegroundColorAttributeName:[Utils colorConvertFromString:@"#333333"]}];
        
        //        textStyle.lineBreakMode = NSLineBreakByWordWrapping;
        float addX = isX>0?5:-45;
        [[NSString stringWithFormat:@"%.1f%%",value*100] drawInRect:CGRectMake(xxxx+addX, yyy-9, 40, 18) withAttributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:style}];
        //填充圆，无边框
        CGContextAddArc(context, xx, yy, 2, 0, 2*M_PI, 1);
        
        [color set];
        CGContextDrawPath(context, kCGPathFill);//绘制填充
    }
    
}


@end
