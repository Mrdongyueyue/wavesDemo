//
//  BezierPathViewController.m
//  wavesDemo
//
//  Created by 董知樾 on 2017/1/13.
//  Copyright © 2017年 董知樾. All rights reserved.
//

#import "BezierPathViewController.h"

@interface BezierPathViewController ()

@property (strong, nonatomic) CADisplayLink *displayLink;

@property (strong, nonatomic) CAShapeLayer *shapeLayer;

@property (strong, nonatomic) UIBezierPath *path;

@property (strong, nonatomic) CAShapeLayer *shapeLayer2;

@property (strong, nonatomic) UIBezierPath *path2;

@property (assign, nonatomic) BOOL add;

@end

@implementation BezierPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = CGRectMake(0, 100, 375, 150);
    [self.view.layer addSublayer:_shapeLayer];
    
    
    _shapeLayer2 = [CAShapeLayer layer];
    _shapeLayer2.frame = CGRectMake(0, 100, 375, 150);
    [self.view.layer addSublayer:_shapeLayer2];
    
    
    
    
    
    
    
    
    _shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    _shapeLayer2.fillColor = [UIColor whiteColor].CGColor;
//    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1];
//    _shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
//    _shapeLayer2.strokeColor = [UIColor whiteColor].CGColor;
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawPath)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
}

- (void)drawPath {
    float max = 30;
    static float y = 30;
    _path = [UIBezierPath bezierPath];
    _path2 = [UIBezierPath bezierPath];
    
    [_path moveToPoint:CGPointMake(0, 0)];
    [_path2 moveToPoint:CGPointMake(0, 0)];
    
    int count = 2;
    float waveLenth = 375.0 / count;
    float waveHeight = 0;
    for (int i = 1; i <= count; i ++) {
        [_path addCurveToPoint:CGPointMake(waveLenth * i,0) controlPoint1:CGPointMake(waveLenth * (i - 0.5) , waveHeight - y) controlPoint2:CGPointMake(waveLenth * (i - 0.5) , y - waveHeight)];
        [_path2 addCurveToPoint:CGPointMake(waveLenth * i,0) controlPoint1:CGPointMake(waveLenth * (i - 0.5) ,y - waveHeight) controlPoint2:CGPointMake(waveLenth * (i - 0.5) , waveHeight - y)];
    }
    
//    [_path addLineToPoint:CGPointMake(375, -100)];
//    [_path addLineToPoint:CGPointMake(0, -100)];
    _path.lineWidth = 1;
    
//    [_path2 addLineToPoint:CGPointMake(375, -100)];
//    [_path2 addLineToPoint:CGPointMake(0, -100)];
    _path2.lineWidth = 1;
    
    _shapeLayer.path = _path.CGPath;
    _shapeLayer2.path = _path2.CGPath;
    
    if (y > max) {
        _add = NO;
    } else {
        if (y < -max) {
            _add = YES;
        }
    }
    if (y == 0) {
        if (_add) {
//            [self.view.layer insertSublayer:_shapeLayer2 below:_shapeLayer];
        } else {
//            [self.view.layer insertSublayer:_shapeLayer below:_shapeLayer2];
        }
    }
    _shapeLayer.fillColor = [UIColor colorWithRed:1-fabsf(y)/max green:1-fabsf(y)/max blue:1-fabsf(y)/max alpha:1].CGColor;
    _shapeLayer2.fillColor = [UIColor colorWithRed:1-fabsf(y)/max green:1-fabsf(y)/max blue:1-fabsf(y)/max alpha:1].CGColor;
//    self.view.backgroundColor = [UIColor colorWithRed:1-fabsf(y)/max green:1-fabsf(y)/max blue:1-fabsf(y)/max alpha:1];
    
    y += _add ? 1 : -1;
}

- (IBAction)dismiss:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
