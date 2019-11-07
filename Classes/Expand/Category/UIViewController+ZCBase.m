//
//  UIViewController+ZCBase.m
//  i84zcc
//
//  Created by 小二 on 2019/9/4.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "UIViewController+ZCBase.h"
#import "ZCLoginViewController.h"
#import "ZCBaesNaVController.h"

@implementation UIViewController (ZCBase)

- (void)presentLoginViewController {
    ZCLoginViewController *vc = [[ZCLoginViewController alloc] init];
    UINavigationController *nav = [[ZCBaesNaVController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:nav animated:YES completion:nil];
}

@end
