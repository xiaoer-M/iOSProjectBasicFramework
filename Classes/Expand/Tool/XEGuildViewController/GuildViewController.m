
//
//  GuildViewController.m
//  OrangeLife
//
//  Created by OrangeLife on 15/11/19.
//  Copyright © 2015年 Shenme Studio. All rights reserved.
//

#import "GuildViewController.h"
#import "ZCInfoTool.h"
#import "ZCTabBarController.h"

#define ResourcesPath @"GuildResources.bundle/"

@interface GuildViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) UIPageControl *page;
@end

@implementation GuildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

#pragma mark -私有方法
- (void)initUI {
    UIScrollView *scrollView = [UIScrollView new];
    [scrollView setPagingEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setDelegate:self];
    [self.view addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIView *contentView = [UIView new];
    [scrollView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.height.equalTo(scrollView);
    }];
    
    
    NSString *imageType = @"";
    if (IS_iPhone_SE) {
        imageType = @"guildPage-SE";
    } else if (IS_iPhone_8) {
        imageType = @"guildPage-8";
    } else if (IS_iPhone_XR) {
        imageType = @"guildPage-XR";
    } else if (IS_iPhone8_Plus) {
        imageType = @"guildPage-8P";
    } else if (IS_iPhoneX) {
        imageType = @"guildPage-X";
    } else if (IS_iPhoneXsMax) {
        imageType = @"guildPage-XsMax";
    }
    
    UIView *lastView = nil;
    for (NSInteger index = 1; index < 4; ++index) {
        UIImageView *pageImageView = [UIImageView new];
        NSString *imageName = [NSString stringWithFormat:@"%@%@%ld.png",ResourcesPath,imageType,(long)index];
        [pageImageView setImage:[UIImage imageNamed:imageName]];
        pageImageView.contentMode = UIViewContentModeScaleToFill;
        [contentView addSubview:pageImageView];
        [pageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeight));
            make.centerY.equalTo(contentView);
            if (lastView) {
                make.left.equalTo(lastView.mas_right);
            } else {
                make.left.equalTo(contentView);
            }
        }];
        if (index == 3)
        {
            UIButton *goButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [goButton.layer setCornerRadius:17];
            [goButton.layer setBorderColor:kMainColor.CGColor];
            [goButton.layer setBorderWidth:1];
            [goButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
            [goButton setTitle:@"立即体验" forState:UIControlStateNormal];
            [goButton addTarget:self action:@selector(goToUse) forControlEvents:UIControlEventTouchUpInside];
            [goButton setTitleColor:kMainColor forState:UIControlStateNormal];
            [pageImageView addSubview:goButton];
            [pageImageView setUserInteractionEnabled:YES];
            
            [goButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(pageImageView);
                make.width.equalTo(@(126));
                make.height.equalTo(@(34));
                make.bottom.equalTo(pageImageView.mas_bottom).offset(-(60+kSafeAreaBottomHeight));
            }];
        }
        lastView = pageImageView;
    }
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastView);
    }];
    
    UIPageControl *pageControl = [UIPageControl new];
    [pageControl setNumberOfPages:3];
    [pageControl setCurrentPage:0];
    [pageControl setCurrentPageIndicatorTintColor:kMainColor];
    [pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
    [self.view addSubview:pageControl];
    self.page = pageControl;
    
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-(10+kSafeAreaBottomHeight));
        make.centerX.equalTo(self.view);
    }];
}

#pragma mark 立即体验
- (void)goToUse {
    //存储App版本
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [ZCInfoTool setValue:version forKey:AppVersion];
    
    //这里修改跳转的界面
    [UIApplication sharedApplication].delegate.window.rootViewController = [ZCTabBarController new];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x /kScreenWidth;
    [self.page setCurrentPage:page];
}

@end




