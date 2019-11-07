//
//  Macros.h
//  i84zcc
//
//  Created by 小二 on 2019/9/2.
//  Copyright © 2019年 小二. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

/*********** 颜色 ***********/
#define UIColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGB(r,g,b,al) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:al]

// Tabbar
#define kTabLightTextColor UIColorFromHex(0x584024)
#define kTabTextColor UIColorFromHex(0xBCBCBC)
#define kvcBackgroundColor UIColorFromHex(0xfaf9f5)  //控制器统一背景

//me
#define kTextColor UIColorFromHex(0x262626)  //文字颜色
#define kGrayColor UIColorFromHex(0x666666)  //灰色文字颜色
#define kPaleColor UIColorFromHex(0x999999)  //淡色文字颜色
#define kMostlightTextColor UIColorFromHex(0xAAAAAA)

//login
#define kMainColor UIColorFromHex(0x584024)  //主题颜色

//rollcall
#define kLineBgColor UIColorFromHex(0xE5E5E5)  //灰色线
#define kYellowBgColor UIColorFromHex(0xFFDA2A)  //黄色按钮




/*********** 字号 ***********/
#define kFont(size) [UIFont systemFontOfSize:size weight:UIFontWeightRegular]
#define kMediumFont(size) [UIFont systemFontOfSize:size weight:UIFontWeightMedium]
#define kBoldFont(size) [UIFont systemFontOfSize:size weight:UIFontWeightBold]




/*********** 尺寸 ***********/
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kIs_iPhoneX ([[UIApplication sharedApplication] statusBarFrame].size.height == 44 ? YES : NO)   //适配刘海机型
#define kStatusBarAndNavigationBarHeight (kIs_iPhoneX ? 88.f : 64.f)
#define kSafeAreaBottomHeight  (kIs_iPhoneX ? 34.0 : 0.0)
#define kTabBarHeight  49.0f
#define kLineHeight 1/[UIScreen mainScreen].scale    //线高度
#define AdapterWidth(width)     (width * kScreenWidth / 375)   //适配宽高
#define AdapterHeight(height)   (height * kScreenHeight / 667)

// 具体机型适配引导页
// iPhone5 iPhone5s iPhoneSE
#define IS_iPhone_SE ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

// iPhone6 7 8
#define IS_iPhone_8 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

// iphoneXR
#define IS_iPhone_XR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

// iPhone6plus  iPhone7plus iPhone8plus
#define IS_iPhone8_Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

// iPhoneX
#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

// iphoneXsMax
#define IS_iPhoneXsMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)




/*********** 实用的宏 ***********/
#define ZCRequestErrorTip NSLocalizedString(@"Error in request, please try again", nil)

// weakSelf
#define Weak_Self   __weak typeof(self) wSelf = self
#define Strong_Self __strong typeof(wSelf) sSelf = wSelf


//class_copyIvarList 实现归档接档
#define LXERuntimeNSCoding(Class) \
- (void)encodeWithCoder:(NSCoder *)encoder{\
    unsigned int outCount = 0;\
    Ivar *ivars = class_copyIvarList([Class class], &outCount);\
    for (int i = 0; i < outCount; i++) {\
        Ivar ivar = ivars[i];\
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];\
        id value = [self valueForKey:key];\
        [encoder encodeObject:value forKey:key];\
    }\
    free(ivars);\
}\
- (instancetype)initWithCoder:(NSCoder *)decoder{\
    if (self = [super init]) {\
        unsigned int outCount = 0;\
        Ivar *ivars = class_copyIvarList([Class class], &outCount);\
        for (int i = 0; i < outCount; i++) {\
            Ivar ivar = ivars[i];\
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];\
            id value = [decoder decodeObjectForKey:key];\
            if (value) {\
            [self setValue:value forKey:key];\
            }\
        }\
        free(ivars);\
    }\
    return self;\
}\

#endif /* Macros_h */
