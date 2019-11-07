//
//  XECodeScanView.h
//  i84cpn
//
//  Created by 小二 on 2018/11/1.
//  Copyright © 2018年 5i84. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XECodeScanViewBlock)(NSString *urlStr);

@interface XECodeScanView : UIView
///回调扫码参数
@property (nonatomic, copy) XECodeScanViewBlock block;

@end
