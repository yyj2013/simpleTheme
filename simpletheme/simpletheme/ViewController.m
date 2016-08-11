//
//  ViewController.m
//  simpletheme
//
//  Created by csyyj on 16/8/11.
//  Copyright © 2016年 imudges. All rights reserved.
//

#import "ViewController.h"
#import "themeFramework.h"
#import "ThemeFrameworkInterface.h"
#import "GNDayNightManager.h"

#define RandomColorValue abs(rand()) % 256 / 256.0
#define RandomColor [UIColor colorWithRed:RandomColorValue green:RandomColorValue blue:RandomColorValue alpha:1]

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *themeView;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setDn_backgroundColorID:@"normalPageBackColor"];
    [_themeLabel dn_setThemeChangeBlock:^(GNDayNightState state) {
        switch (state) {
            case GNDayNightDayState:
            {
                [_themeLabel setText:@"日间模式"];
                [_themeLabel sizeToFit];
            }
                break;
            case GNDayNightNightState:
            {
                [_themeLabel setText:@"夜间主题"];
                [_themeLabel sizeToFit];
            }
                break;
                
            default:
                break;
        }
    }];
    [_themeView dn_setThemeChangeBlock:^(GNDayNightState state) {
        [_themeView setBackgroundColor:RandomColor];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)onThemeButtonClick:(id)sender {
    [GNDayNightManagerInstance switchState];
}

@end
