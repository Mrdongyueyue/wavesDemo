//
//  YYWaveView.m
//  wavesDemo
//
//  Created by 董知樾 on 2017/8/22.
//  Copyright © 2017年 董知樾. All rights reserved.
//

#import "YYWaveView.h"

@interface YYWaveView ()

@property (nonatomic, strong) CAShapeLayer *waveLayer0;
@property (nonatomic, strong) CAShapeLayer *waveLayer1;
@property (strong, nonatomic) UIBezierPath *path0;
@property (strong, nonatomic) UIBezierPath *path1;
@property (strong, nonatomic) CADisplayLink *displayLink;

@end

@implementation YYWaveView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createWave];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self createWave];
    }
    return self;
}


- (void)createWave {
    _waveLayer0 = [CAShapeLayer layer];
    _waveLayer1 = [CAShapeLayer layer];
    
    [self.layer addSublayer:_waveLayer0];
    [self.layer addSublayer:_waveLayer1];
    
    //initialize settings
    _valueForA = 10.f;
    _valueFork = 0;
    _valueForω = 0.02;
    _valueForφ = 0;
    _rate = 1;
}

- (void)drawPath {
    static double i = 0;
    
    CGFloat A = _valueForA;//A振幅
    CGFloat k = _valueFork;//y轴偏移
    CGFloat ω = _valueForω;//角速度ω变大，则波形在X轴上收缩（波形变紧密）；角速度ω变小，则波形在X轴上延展（波形变稀疏）。不等于0
    CGFloat φ = _valueForφ + i;//初相，x=0时的相位；反映在坐标系上则为图像的左右移动。
    //y=Asin(ωx+φ)+k
    
    _path0 = [UIBezierPath bezierPath];
    _path1 = [UIBezierPath bezierPath];
    
    [_path0 moveToPoint:CGPointZero];
    [_path1 moveToPoint:CGPointZero];
    CGFloat width = self.bounds.size.width;
    for (NSInteger i = 0; i < (NSInteger)width; i ++) {
        CGFloat x = i;
        CGFloat y = A * sin(ω*x+φ)+k;
        CGFloat y2 = A * cos(ω*x+φ)+k;
        [_path0 addLineToPoint:CGPointMake(x, y)];
        [_path1 addLineToPoint:CGPointMake(x, y2)];
    }
    [_path0 addLineToPoint:CGPointMake(width, _waveHeight)];
    [_path0 addLineToPoint:CGPointMake(0, _waveHeight)];
    _path0.lineWidth = 1;
    
    _waveLayer0.path = _path0.CGPath;
    
    [_path1 addLineToPoint:CGPointMake(width, _waveHeight)];
    [_path1 addLineToPoint:CGPointMake(0, _waveHeight)];
    _path1.lineWidth = 1;
    
    _waveLayer1.path = _path1.CGPath;
    
    i += 0.1 * _rate;
    if (i > M_PI * 2) {
        i = 0;//防止i越界
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _waveLayer0.frame = CGRectMake(0, self.bounds.size.height - _waveHeight, self.bounds.size.width, _waveHeight);
    _waveLayer1.frame = CGRectMake(0, self.bounds.size.height - _waveHeight, self.bounds.size.width, _waveHeight);
}

- (void)setWaveHeight:(CGFloat)waveHeight {
    _waveHeight = waveHeight;
    _waveLayer0.frame = CGRectMake(0, self.bounds.size.height - waveHeight, self.bounds.size.width, waveHeight);
    _waveLayer1.frame = CGRectMake(0, self.bounds.size.height - waveHeight, self.bounds.size.width, waveHeight);
}

- (void)setWaveColor:(UIColor *)waveColor {
    _waveColor = waveColor;
    _waveLayer0.fillColor = waveColor.CGColor;
    _waveLayer1.fillColor = waveColor.CGColor;
}

- (void)beginAnimation {
    if (_displayLink) {
        [_displayLink invalidate];
        _displayLink = nil;
    }
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawPath)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)stopAnimation {
    if (_displayLink) {
        [_displayLink invalidate];
        _displayLink = nil;
    }
}

@end
