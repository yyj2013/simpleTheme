//
//  GNDayNightImageView.m
//  baseframework
//
//  Created by baidu on 16/5/25.
//  Copyright © 2016年 youxibar. All rights reserved.
//

#import "GNDayNightImageButton.h"
#import "GNDayNightManager.h"

@interface GNDayNightImageButton ()

@end

@implementation GNDayNightImageButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dn_isNeedTheme = @(YES);
    }
    return self;
}

- (void)setTextColorID:(NSString *)textColorID {
    _textColorID = textColorID;
    [self.titleLabel setTextColor:UIColorFromRGB([GNDayNightManagerInstance getColorWithColorID:textColorID])];
}

- (void)setImgIdName:(NSString *)imgIdName {
    _imgIdName = imgIdName;
    [self setImage:GNPNGImage([GNDayNightManagerInstance getIconNameWithIcon:_imgIdName type:GNButtonImgNormalType]) forState:UIControlStateNormal];
    [self setImage:GNPNGImage([GNDayNightManagerInstance getIconNameWithIcon:_imgIdName type:GNButtonImgPressType]) forState:UIControlStateHighlighted];
}

- (void)dn_onDayNightStateHasChange:(GNDayNightState)state {
    [super dn_onDayNightStateHasChange:state];
    [UIView animateWithDuration:GNCommonAnimationsTime animations:^{
        if (_imgIdName && [_imgIdName length]) {
            [self setImage:GNPNGImage([GNDayNightManagerInstance getIconNameWithIcon:_imgIdName type:GNButtonImgNormalType]) forState:UIControlStateNormal];
            [self setImage:GNPNGImage([GNDayNightManagerInstance getIconNameWithIcon:_imgIdName type:GNButtonImgPressType]) forState:UIControlStateHighlighted];
        }
        if (_textColorID && [_textColorID length]) {
            [self.titleLabel setTextColor:UIColorFromRGB([GNDayNightManagerInstance getColorWithColorID:_textColorID])];
        }

    }];
}

@end
