//
//  ViewController.m
//  wavesDemo
//
//  Created by 董知樾 on 2017/1/11.
//  Copyright © 2017年 董知樾. All rights reserved.
//

#define color(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) CADisplayLink *displayLink;

@property (strong, nonatomic) CAShapeLayer *shapeLayer;

@property (strong, nonatomic) UIBezierPath *path;

@property (strong, nonatomic) CAShapeLayer *shapeLayer2;

@property (strong, nonatomic) UIBezierPath *path2;

@property (strong, nonatomic) CAGradientLayer *gradientLayer;

@property (strong, nonatomic) CAGradientLayer *gradientLayer2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = CGRectMake(0, 100, 375, 150);
    
    _shapeLayer2 = [CAShapeLayer layer];
    _shapeLayer2.frame = CGRectMake(0, 100, 375, 150);
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawPath)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    [self addGradient1];
    [self addGradient2];
}

- (void)drawPath {
    static double i = 0;
    
    CGFloat A = 10.f;//A振幅
    CGFloat k = 0;//y轴偏移
    CGFloat ω = 0.03;//角速度ω变大，则波形在X轴上收缩（波形变紧密）；角速度ω变小，则波形在X轴上延展（波形变稀疏）。不等于0
    CGFloat φ = 0 + i;//初相，x=0时的相位；反映在坐标系上则为图像的左右移动。
    //y=Asin(ωx+φ)+k
    
    _path = [UIBezierPath bezierPath];
    _path2 = [UIBezierPath bezierPath];
    
    [_path moveToPoint:CGPointZero];
    [_path2 moveToPoint:CGPointZero];
    for (int i = 0; i < 376; i ++) {
        CGFloat x = i;
        CGFloat y = A * sin(ω*x+φ)+k;
        CGFloat y2 = A * cos(ω*x+φ)+k;
        [_path addLineToPoint:CGPointMake(x, y)];
        [_path2 addLineToPoint:CGPointMake(x, y2)];
    }
    [_path addLineToPoint:CGPointMake(375, -100)];
    [_path addLineToPoint:CGPointMake(0, -100)];
    _path.lineWidth = 1;
    
    _shapeLayer.path = _path.CGPath;
    
    [_path2 addLineToPoint:CGPointMake(375, -100)];
    [_path2 addLineToPoint:CGPointMake(0, -100)];
    _path2.lineWidth = 1;
    
    _shapeLayer2.path = _path2.CGPath;
    
    i += 0.1;
    if (i > M_PI * 2) {
        i = 0;//防止i越界
    }
    _gradientLayer.mask = _shapeLayer;
    _gradientLayer2.mask = _shapeLayer2;
}

- (void)addGradient1 {
    //139 70 83
    //174 252 217
    _gradientLayer = [CAGradientLayer layer];
    NSInteger count = 20;
    NSMutableArray *colors = [NSMutableArray array];
    NSMutableArray *locations = [NSMutableArray array];
    for (NSInteger i = 0; i < count ; i ++) {
        UIColor *color = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:0.3];
        [colors addObject:(__bridge id)color.CGColor];
        [locations addObject:@(i /(CGFloat)count)];
    }
    //颜色数组
    _gradientLayer.colors = colors;
    //可以不设置
    _gradientLayer.locations = locations;
    //startPoint endPoint 确定条纹方向 不设置 默认水平默认值[.5,0]和[.5,1]
    _gradientLayer.startPoint = CGPointMake(0, 0);
    _gradientLayer.endPoint = CGPointMake(1, 1);
    
    _gradientLayer.type = kCAGradientLayerAxial;
    
    _gradientLayer.frame = CGRectMake(0, 0, 375, 150);
    
    [self.view.layer addSublayer:_gradientLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    
    animation.duration = 2;
    
    animation.repeatCount = MAXFLOAT;
    
    NSMutableArray *toValue = [NSMutableArray array];
    
    for (NSInteger i = 0; i < count ; i ++) {
        
        UIColor *color = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:0.3];
        
        [toValue addObject:(__bridge id)color.CGColor];
        
    }
    animation.autoreverses = YES;
    animation.toValue = toValue;
    [_gradientLayer addAnimation:animation forKey:@"gradientLayer"];
    
}
- (void)addGradient2 {
    
    _gradientLayer2 = [CAGradientLayer layer];
    NSInteger count = 20;
    NSMutableArray *colors = [NSMutableArray array];
    NSMutableArray *locations = [NSMutableArray array];
    for (NSInteger i = 0; i < count ; i ++) {
        UIColor *color = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:0.3];
        [colors addObject:(__bridge id)color.CGColor];
        [locations addObject:@(i /(CGFloat)count)];
    }
    //颜色数组
    _gradientLayer2.colors = colors;
    //可以不设置
    _gradientLayer2.locations = locations;
    //startPoint endPoint 确定条纹方向 不设置 默认水平默认值[.5,0]和[.5,1]
    _gradientLayer2.startPoint = CGPointMake(1, 0);
    _gradientLayer2.endPoint = CGPointMake(0, 1);
    
    _gradientLayer2.type = kCAGradientLayerAxial;
    
    _gradientLayer2.frame = CGRectMake(0, 0, 375, 150);
    
    [self.view.layer addSublayer:_gradientLayer2];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    
    animation.duration = 2;
    
    animation.repeatCount = MAXFLOAT;
    
    NSMutableArray *toValue = [NSMutableArray array];
    
    for (NSInteger i = 0; i < count ; i ++) {
        
        UIColor *color = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:0.3];
        
        [toValue addObject:(__bridge id)color.CGColor];
        
    }
    animation.autoreverses = YES;
    animation.toValue = toValue;
    [_gradientLayer2 addAnimation:animation forKey:@"gradientLayer"];
    
}





@end
