//
//  YYWaveView.h
//  wavesDemo
//
//  Created by 董知樾 on 2017/8/22.
//  Copyright © 2017年 董知樾. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 函数y=Asin(ωx+φ)+k
 */
@interface YYWaveView : UIView

/**
 A振幅 default 10.0
 */
@property (nonatomic, assign) IBInspectable CGFloat valueForA;

/**
 y轴偏移 default 0
 */
@property (nonatomic, assign) IBInspectable CGFloat valueFork;

/**
 角速度ω变大，则波形在X轴上收缩（波形变紧密）；角速度ω变小，则波形在X轴上延展（波形变稀疏）。不等于0
 default 0.02
 */
@property (nonatomic, assign) IBInspectable CGFloat valueForω;

/**
 初相，x=0时的相位；反映在坐标系上则为图像的左右移动。 default 0.0
 */
@property (nonatomic, assign) IBInspectable CGFloat valueForφ;


/**
 波动速率，default 1 越大波动越快
 */
@property (nonatomic, assign) IBInspectable CGFloat rate;

@property (nonatomic, assign) IBInspectable CGFloat waveHeight;

@property (nonatomic, strong) IBInspectable UIColor *waveColor;

/**
 开始浪
 */
- (void)beginAnimation;

/**
 别浪了
 */
- (void)stopAnimation;

@end
