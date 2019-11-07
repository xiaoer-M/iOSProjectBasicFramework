//
//  UIAlertController+Factory.m
//  i84zcc
//
//  Created by 小二 on 2019/9/17.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "UIAlertController+Factory.h"
#import <objc/runtime.h>

@implementation UIAlertController (Factory)

+ (void)presentAlertControllerWithTitle:(NSString *)title
                                message:(NSString *)message
                            actionTitle:(NSString *)actionTitle
                                handler:(void(^)(UIAlertAction *action))actionBlock {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        !actionBlock ?: actionBlock(action);
    }];
    
    [alert addAction:cancelAction];
    
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
}


+ (void)presentAlertControllerWithTitle:(NSString *)title
                                message:(NSString *)message
                            cancelTitle:(NSString *)cancelTitle
                           defaultTitle:(NSString *)defaultTitle
                               distinct:(BOOL)distinct
                          cancelHandler:(void(^)(UIAlertAction *action))cancelBlock
                         defaultHandler:(void(^)(UIAlertAction *action))defaultBlock {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertActionStyle actionStyle = distinct ? UIAlertActionStyleCancel : UIAlertActionStyleDefault;  // 左浅右深
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:actionStyle handler:^(UIAlertAction * _Nonnull action) {
        !cancelBlock ?: cancelBlock(action);
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:defaultTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        !defaultBlock ?: defaultBlock(action);
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:confirmAction];
    
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
}


+ (void)presentAlertControllerWithTitle:(NSString *)title
                                message:(NSString *)message
                           actionTitles:(NSArray *)actionTitles
                         preferredStyle:(UIAlertControllerStyle)preferredStyle
                                handler:(void(^)(NSUInteger buttonIndex, NSString *buttonTitle))actionBlock {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:SCIsEmptyString(title) ? nil : title message:SCIsEmptyString(message) ? nil : message preferredStyle:preferredStyle];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        actionBlock(0, NSLocalizedString(@"Cancel", nil));
    }];
    [alert addAction:cancelAction];
    
    for (int i = 0; i < actionTitles.count; i++) {
        UIAlertAction *confimAction = [UIAlertAction actionWithTitle:actionTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            actionBlock((i+1), actionTitles[i]);
        }];
        [alert addAction:confimAction];
    }
    
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

@end
