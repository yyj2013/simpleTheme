//
//  GNDayNightManager.m
//  GameNews
//
//  Created by csyyj on 16/5/25.
//  Copyright © 2016年 youxibar. All rights reserved.
//

#import "GNDayNightManager.h"
#import "GNPlistHandle.h"

#define kGNDayThemePlistSource @"day_theme_config"                 //日间主题plist
#define kGNNightThemePlistSource @"night_theme_config"             //夜间主题plist

NSString * const GNDAYNIGHT_STATE_CHANGE = @"GNDAYNIGHT_STATE_CHANGE";    //夜间<->日间模式切换通知

static GNDayNightManager *_dayNightManager = nil;

@interface GNDayNightManager ()

@property (nonatomic, strong) NSDictionary *plistDict;

@property (nonatomic, strong) NSDictionary *buttonImgDict; //按钮图片存放的dictionary

@property (nonatomic, strong) NSDictionary *textColorDict; //文字颜色存放的dictionary

@end

@implementation GNDayNightManager

+ (GNDayNightManager*)sharedInstance {
    if (!_dayNightManager) {
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
            _dayNightManager = [[GNDayNightManager alloc] init];
            [_dayNightManager p_resetDate];
        });
    }
    
    return _dayNightManager;
}

- (void)switchState {
    if (_state == GNDayNightDayState) {
        self.state = GNDayNightNightState;
    }
    else
    {
        self.state = GNDayNightDayState;
    }
}

- (void)setState:(GNDayNightState)state {
    if (state == _state && state != GNDayNightInvalidState) {
        return;
    }
    _state = state;
    [self p_resetDate];
    [[NSNotificationCenter defaultCenter] postNotificationName:GNDAYNIGHT_STATE_CHANGE object:nil];
}

- (NSString *)getRelativePath {
    NSString *subPath = @"theme/";
    switch (_state) {
        case GNDayNightDayState:{
            subPath = [NSString stringWithFormat:@"%@theme_day/",subPath];
        }
            break;
        case GNDayNightNightState:{
            subPath = [NSString stringWithFormat:@"%@theme_night/",subPath];
        }
            break;
        default:
            break;
    }
    return subPath;
}

- (NSString *)getThemePath {
    NSString *rootPath = [[NSBundle bundleForClass:[self class]] resourcePath];
    return [rootPath stringByAppendingPathComponent:[self getRelativePath]];
}


- (int)getColorWithColorID:(NSString *)colorID {
    NSString *colorStr = @"0xffffff";
    if (!_textColorDict) {
        [self p_resetDate];
    }
    if (_textColorDict) {
        colorStr = [[_textColorDict objectForKey:colorID] objectForKey:@"color"];
    }
    unsigned int colorInt = 0xffffff;
    [[NSScanner scannerWithString:colorStr] scanHexInt:&colorInt];
    return colorInt;
}

- (UIImage *)getImageWithIconID:(NSString *)iconID {
    NSString *path = nil;
    NSString *suffix = nil;
    if ([UIScreen mainScreen].scale < 3) {
        suffix = @"@2x.png";
    }else {
        suffix = @"@3x.png";
    }
    if ([iconID hasSuffix:@".png"] || [iconID hasSuffix:@".jpg"]) {
        path = iconID;
    }
    else {
        path = [NSString stringWithFormat:@"%@%@",iconID,suffix];
    }
    
    NSString *imgPath = [self.themePath stringByAppendingPathComponent:path];
    UIImage *image = [UIImage imageWithContentsOfFile:imgPath];
    if (!image) {
        image = [UIImage imageNamed:imgPath];
    }
    return image;
}

#pragma mark - private
/**
 *  根据当前主题状态，加载不同主题配置文件
 */
- (void)p_resetDate {
    NSString *plistSource = @"";
    switch (_state) {
        case GNDayNightDayState:
        {
            plistSource = kGNDayThemePlistSource;
        }
            break;
        case GNDayNightNightState:
        {
            plistSource = kGNNightThemePlistSource;
        }
            break;
            
        default:
            break;
    }
    _plistDict = [GNPlistHandle handlePlistToDictWithResource:plistSource dir:[self getRelativePath]];
    if (_plistDict) {
        self.buttonImgDict = [_plistDict objectForKey:@"buttonImage"];
        self.textColorDict = [_plistDict objectForKey:@"textColor"];
    }
}


@end