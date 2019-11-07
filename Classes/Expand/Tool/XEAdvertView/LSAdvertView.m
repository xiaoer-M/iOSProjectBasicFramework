//
//  LSAdvertView.m
//  ELaw
//
//  Created by 伪装者 on 2018/7/21.
//  Copyright © 2018年 xe. All rights reserved.
//

#import "LSAdvertView.h"

@interface LSAdvertView ()
///图片
@property (nonatomic, strong) UIImageView *adView;
///底部logo
@property (nonatomic, strong) UIImageView *logoImgView;
///按钮
@property (nonatomic, strong) UIButton *countBtn;
///定时器
@property (nonatomic, strong) NSTimer *countTimer;
///计时
@property (nonatomic, assign) NSUInteger count;

@end

// 广告显示的时间
static int const showtime = 3;

@implementation LSAdvertView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        // 1.广告图片
        _adView = [[UIImageView alloc] initWithFrame:frame];
        _adView.userInteractionEnabled = YES;
        _adView.contentMode = UIViewContentModeScaleAspectFill;
        _adView.clipsToBounds = YES;
        //        _adView.image = [UIImage imageNamed:@"LaunchImage_667h"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAd)];
        [_adView addGestureRecognizer:tap];
        
        // 2.跳过按钮
        CGFloat btnW = 60;
        CGFloat btnH = 30;
        _countBtn = [[UIButton alloc] initWithFrame:CGRectMake(kscreenWidth - btnW - 24, btnH, btnW, btnH)];
        [_countBtn addTarget:self action:@selector(removeAdvertView) forControlEvents:UIControlEventTouchUpInside];
        [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d", showtime] forState:UIControlStateNormal];
        _countBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _countBtn.backgroundColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:0.6];
        _countBtn.layer.cornerRadius = 4;
        
        //3.底部logo
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kscreenHeight - 100, kscreenWidth, 100)];
        bgView.backgroundColor = [UIColor whiteColor];
        _logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake((kscreenWidth - 150)/2, (100 - 40)/2, 150, 40)];
        _logoImgView.image = [UIImage imageNamed:@"guildPage1"];
        _logoImgView.contentMode = UIViewContentModeScaleAspectFit;
        _logoImgView.backgroundColor = [UIColor whiteColor];
        [bgView addSubview:_logoImgView];
        
        [self addSubview:_adView];
        [self addSubview:_countBtn];
        [self addSubview:bgView];
    }
    return self;
}

- (void)setFilePath:(NSString *)filePath {
    _filePath = filePath;
    _adView.image = [UIImage imageWithContentsOfFile:filePath];
}

- (void)pushToAd {
    [self removeAdvertView];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZLPushToAdvert" object:_pushUrl userInfo:nil];
}

- (void)countDown {
    _count --;
    [_countBtn setTitle:[NSString stringWithFormat:@"跳过%ld",(long)_count] forState:UIControlStateNormal];
    if (_count == 0) {
        
        [self removeAdvertView];
    }
}

- (void)show {
    // 倒计时方法1：GCD
    //    [self startCoundown];
    
    // 倒计时方法2：定时器
    [self startTimer];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
}

// 定时器倒计时
- (void)startTimer {
    _count = showtime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}

// GCD倒计时
- (void)startCoundown {
    __weak __typeof(self) weakSelf = self;
    __block int timeout = showtime + 1; //倒计时时间 + 1
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf removeAdvertView];
                
            });
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.countBtn setTitle:[NSString stringWithFormat:@"跳过%d",timeout] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

// 移除广告页面
- (void)removeAdvertView {
    // 停掉定时器
    [self.countTimer invalidate];
    self.countTimer = nil;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (NSTimer *)countTimer {
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

@end
