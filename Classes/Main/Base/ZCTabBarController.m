//
//  ZCTabBarController.m
//  i84zcc
//
//  Created by 小二 on 2019/9/3.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "ZCTabBarController.h"
#import "ZCBaesNaVController.h"
#import "ZCLoginViewController.h"

@interface ZCTabBarController ()

@end

@implementation ZCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*点名*/
    UIViewController *rollCallVC = [[UIViewController alloc] init];
    ZCBaesNaVController *rollCallNav = [[ZCBaesNaVController alloc] initWithRootViewController:rollCallVC];
    [rollCallNav setTabBarItem:[self createTabbarItemWithTitle:NSLocalizedString(@"RollCall", nil) imagePath:@"rollcall_normal" selectedImagePath:@"rollcall_selected"]];

    /*我的*/
    ZCLoginViewController *meVC = [[ZCLoginViewController alloc] init];
    ZCBaesNaVController *meNav = [[ZCBaesNaVController alloc] initWithRootViewController:meVC];
    [meNav setTabBarItem:[self createTabbarItemWithTitle:NSLocalizedString(@"Me", nil) imagePath:@"me_normal" selectedImagePath:@"me_selected"]];

    [self setViewControllers:@[rollCallNav,meNav]];
}

/**
 *
 *  创建对应的导航按钮
 *
 *  @param title             标题
 *  @param imagePath         正常图片路径
 *  @param selectedImagePath 选中图片路径
 *
 *  @return 生成的按钮
 */
- (UITabBarItem *)createTabbarItemWithTitle:(NSString *)title imagePath:(NSString *)imagePath selectedImagePath:(NSString *)selectedImagePath
{
    UIImage *image = [[UIImage imageNamed:imagePath] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:selectedImagePath] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:kTabTextColor,NSFontAttributeName:kFont(12)} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:kTabLightTextColor,NSFontAttributeName:kFont(12)} forState:UIControlStateSelected];
    
    // 解决iOS13bug，当我们push到下一页再次返回时，上面这种tabbar颜色设置会失效，这里设置个tintColor解决
    self.tabBar.tintColor = kTabLightTextColor;
    
    return item;
}


@end
