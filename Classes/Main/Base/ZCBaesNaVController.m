//
//  ZCBaesNaVController.m
//  i84zcc
//
//  Created by 小二 on 2019/9/5.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "ZCBaesNaVController.h"

@interface ZCBaesNaVController ()

@end

@implementation ZCBaesNaVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
        //设置透明，默认为NO控制器中y=0实际效果上=64，设置为YES时控制器中y=0实际效果上y=0
        self.navigationBar.translucent = NO;
        //设置字体颜色
        [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
        //设置背景颜色
        [self.navigationBar setBarTintColor:[UIColor whiteColor]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.view.backgroundColor = kvcBackgroundColor;
    
    // 第一次加载就会调用一次push，所以第一次进来数组是空的，第二次才会进判断
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        //设置返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popView)];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)popView {
    [self popViewControllerAnimated:YES];
}

@end
