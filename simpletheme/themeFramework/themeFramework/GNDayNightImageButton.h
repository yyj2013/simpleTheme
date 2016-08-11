//
//  GNDayNightImageView.h
//  baseframework
//
//  Created by baidu on 16/5/25.
//  Copyright © 2016年 youxibar. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 * 考虑到多处UIButton需要处理夜间、日间状态，在此类统一处理，
 */
@interface GNDayNightImageButton : GNButton

@property (nonatomic, strong) NSString *imgIdName;      //图片ID
@property (nonatomic, strong) NSString *textColorID;    //文字颜色ID

@end
