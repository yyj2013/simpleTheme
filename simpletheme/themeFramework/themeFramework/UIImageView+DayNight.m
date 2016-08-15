//
//  UIImageView+DayNight.m
//  themeFramework
//
//  Created by csyyj on 16/8/15.
//  Copyright © 2016年 imudges. All rights reserved.
//

#import "UIImageView+DayNight.h"
#import "UIView+DayNight.h"
#import <objc/runtime.h>

static int imageIdKey;

@implementation UIImageView (DayNight)

- (NSString *)dn_imgaeID {
    return objc_getAssociatedObject(self, &imageIdKey);
}

- (void)setDn_imageID:(NSString *)imageId {
    if (imageId) {
        objc_setAssociatedObject(self, &imageIdKey, imageId, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)dn_setImageId:(NSString *)imageId {
    if ([imageId length] > 0) {
        self.dn_isNeedTheme = YES;
        UIImage *image = [GNDayNightManagerInstance getImageWithIconID:imageId];
        if (image) {
            [self setImage:image];
        }
    }
}

- (void)dn_onDayNightStateHasChange:(GNDayNightState)state {
    [self dn_setImageId:[self dn_imgaeID]];
}

@end
