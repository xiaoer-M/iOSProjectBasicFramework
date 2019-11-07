//
//  XEButton.h
//  i84zcc
//
//  Created by 小二 on 2019/9/25.
//  Copyright © 2019年 小二. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, XEButtonRollCallStyle) {
    XEButtonRollCallStyleNotCall,
    XEButtonRollCallStylePrepareCall,
    XEButtonRollCallStyleCall
};

typedef NS_ENUM(NSInteger, XELayoutButtonStyle) {
    XELayoutButtonStyleLeftImageRightTitle,  //左图右字
    XELayoutButtonStyleLeftTitleRightImage,  //左字右图
    XELayoutButtonStyleUpImageDownTitle,     //上图下字
    XELayoutButtonStyleUpTitleDownImage      //上字下图
};

typedef NS_ENUM(NSInteger, XELayoutContent) {
    XELayoutContentCenter,  //整体居中
    XELayoutContentLeft,    //整体靠左
    XELayoutContentRight,   //整体靠右
};

@interface XEButton : UIButton
/// 布局方式
@property (nonatomic, assign) XELayoutButtonStyle layoutStyle;
/// 图片和文字的间距，默认值8
@property (nonatomic, assign) CGFloat midSpacing;
/// 整体靠右/靠左/居中
@property (nonatomic, assign) XELayoutContent layoutContent;
/// 点名类型（整车厂项目专用）
@property (nonatomic, assign) XEButtonRollCallStyle rollCallStyle;

@end

NS_ASSUME_NONNULL_END
