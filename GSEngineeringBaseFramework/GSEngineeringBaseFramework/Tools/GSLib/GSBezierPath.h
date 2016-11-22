//
//  GSBezierPath.h
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/5/25.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSBezierPath : NSObject

+ (void)bezierPathWith:(UIView *)v;

+ (void)bezierPathWith:(UIView *)v with:(UIRectCorner)corner bycornerRadii:(CGSize)size;

+ (void)bezierPathDrawDottedLineWith:(UIView *)v;

@end
