//
//  MBProgressHUD+MJ.h
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (MB)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (void)showSuccess:(NSString *)success finish:(void (^)(void))finish;

+ (void)showError:(NSString *)error finish:(void (^)(void))finish;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;
+(void)ShowWDMessage:(NSString*)message;
+(void)ShowLongMessage:(NSString *)message;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view duration:(CGFloat)duration;
+ (void)showError:(NSString *)error toView:(UIView *)view duration:(CGFloat)duration;

+ (void)showSuccess:(NSString *)success duration:(CGFloat)duration;

+ (void)showError:(NSString *)error duration:(CGFloat)duration;
@end
