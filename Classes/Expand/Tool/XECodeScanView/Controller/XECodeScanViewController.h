//
//  XECodeScanViewController.h
//  i84cpn
//
//  Created by 小二 on 2018/11/1.
//  Copyright © 2018年 5i84. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XECodeScanBlock)(NSString *urlStr);

@interface XECodeScanViewController : UIViewController
///回调扫码参数
@property (nonatomic, copy) XECodeScanBlock block;

@end
