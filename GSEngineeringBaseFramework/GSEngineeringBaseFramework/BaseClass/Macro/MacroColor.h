//
//  MacroColor.h
//  GSEngineeringBaseFramework
//
//  Created by 关宇琼 on 16/5/5.
//  Copyright © 2016年 GuanSir. All rights reserved.
//

#ifndef MacroColor_h
#define MacroColor_h


#define gs_Color_Navi    [UIColor colorWithRed:245 / 255.0 green:107 / 255. blue:24 / 255.0 alpha:1.0f]    //上方导航条颜色

#define gs_Color_Back [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0f] // 背景色

#define gs_Color_Lightgrey [UIColor colorWithRed:160 /255.0 green:160 /255.0 blue:160 /255.0 alpha:1.0] // 浅灰字色

#define gs_Color_Bt  [UIColor colorWithRed:0 /255.0 green:128 /255.0 blue:68 /255.0 alpha:1.0]  // 深绿button

#define gs_Color_Black  [UIColor colorWithRed: 40 /255.0 green: 40 /255.0 blue: 40 /255.0 alpha:1.0]  // 正常 黑字

/**
 *  颜色类
 */

/* rgb颜色转换（16进制->10进制）*/
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/* 获取RGB颜色 */
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define gs_PinglunFontColor               UIColorFromRGB(0xb6b6b6)//添加评论字颜色

#define gs_PinglunColor                   UIColorFromRGB(0x333333)//评论的颜色

#define gs_PinglunTimeColor               UIColorFromRGB(0x999999)//评论的时间的颜色

#define gs_UserNameColor                  UIColorFromRGB(0x3e3e3e)//评论的颜色


#endif /* MacroColor_h */
