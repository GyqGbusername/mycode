//
//  GSBezierPath.m
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/5/25.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import "GSBezierPath.h"

@implementation GSBezierPath


/**
 *  直接切圆
 *
 *  @param v 控件
 */

+ (void)bezierPathWith:(UIView *)v {
    //    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_barImageView.bounds byRoundingCorners:UIRectCornerTopLeft |  UIRectCornerBottomLeft cornerRadii:_barImageView.bounds.size];
    
    [self bezierPathWith:v with:UIRectCornerAllCorners bycornerRadii:v.bounds.size];
}

/**
 *  贝塞尔曲线切割圆角
 *
 *  @param v      控件
 *  @param corner 角
 *  @param size   圆角弧度
 */

+ (void)bezierPathWith:(UIView *)v with:(UIRectCorner)corner bycornerRadii:(CGSize)size {
    /**
     *
     *  @param UIRectCorner  左上 UIRectCornerTopLeft     = 1 << 0,  右上 UIRectCornerTopRight    = 1 << 1, 左下 UIRectCornerBottomLeft  = 1 << 2,  右下 UIRectCornerBottomRight = 1 << 3,  所有角 UIRectCornerAllCorners  = ~0UL
     *
     */
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:v.bounds byRoundingCorners:corner cornerRadii:size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = v.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    
    v.layer.mask = maskLayer;
}
/**
 *  沿控件内侧画虚线
 *
 *  @param v 传入控件
 */
+ (void)bezierPathDrawDottedLineWith:(UIView *)v {
    
    CAShapeLayer *border = [CAShapeLayer layer];
    
    border.strokeColor = [UIColor lightGrayColor].CGColor;
    
    border.fillColor = nil;
    
    border.path = [UIBezierPath bezierPathWithRect:CGRectMake(4, 4, v.frame.size.width - 8, v.frame.size.height - 8)].CGPath;
    
    border.lineWidth = 0.7f;
    
    border.lineCap = @"square";
    
    border.lineDashPattern = @[@3, @2];
    
    [v.layer addSublayer:border];

}


@end
