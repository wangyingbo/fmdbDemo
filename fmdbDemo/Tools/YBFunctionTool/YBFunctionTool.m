//
//  YBFunctionTool.m
//  fmdbDemo
//
//  Created by fengbang on 2019/9/25.
//  Copyright © 2019 王颖博. All rights reserved.
//

#import "YBFunctionTool.h"
#import <UIKit/UIKit.h>

@implementation YBFunctionTool

/**
 判断是否是iPhone X/XS/XR/XS Max
 
 @return bool值
 */
inline BOOL public_isIPhoneXSeries() {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    
    return iPhoneXSeries;
}

@end
